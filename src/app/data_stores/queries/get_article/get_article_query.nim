import std/asyncdispatch
import std/json
import std/options
import allographer/query_builder
from ../../../../config/database import rdb
import ../../../errors
import ../../../usecases/get_article/get_article_query_interface
import ../../../usecases/get_article/get_article_dto
import ../../../models/aggregates/article/vo/article_id


type GetArticleQuery* = object of IGetArticleQuery

proc new*(_:type GetArticleQuery):GetArticleQuery =
  return GetArticleQuery()


method invoke*(self:GetArticleQuery, articleId:ArticleId):Future[GetArticleDto] {.async.} =
  let resOpt = rdb.select(
                "title",
                "description",
                "body",
                "article.created_at as createdAt",
                "author_id as authorId",
                "user.id",
                "user.name",
                "user.image",
              )
              .table("article")
              .join("user", "user.id", "=", "article.author_id")
              .find(articleId.value, key="article.id")
              .await

  let res = 
    if resOpt.isSome():
      resOpt.get()
    else:
      raise newException(IdNotFoundError, "invalid article id")

  let articleTagCount = rdb.table("tag_article_map")
                            .where("article_id", "=", articleId.value)
                            .count()
                            .await

  let tags =
    if articleTagCount > 0:
      rdb.select(
            "tag_article_map.tag_id as tagId",
            "tag_article_map.article_id as articleId",
            "tag.tag_name as tagName",
          )
          .table("tag_article_map")
          .join("tag", "tag.id", "=", "tag_article_map.tag_id")
          .where("tag_article_map.article_id", "=", articleId.value)
          .get(TagDto)
          .await
    else:
      newSeq[TagDto]()

  let article = ArticleDto.new(
    id = articleId.value,
    title = res["title"].getStr(),
    description = res["description"].getStr(),
    body = res["body"].getStr(),
    createdAt = res["createdAt"].getStr(),
    tags = tags,
  )

  let user = UserDto.new(
    id = res["authorId"].getStr(),
    name = res["name"].getStr(),
    image = res["image"].getStr()
  )

  let dto = GetArticleDto.new(
    article = article,
    user = user
  )
  return dto
