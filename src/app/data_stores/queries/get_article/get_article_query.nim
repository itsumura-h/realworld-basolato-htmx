import std/asyncdispatch
import std/json
import std/options
import allographer/query_builder
import basolato/core/base
from ../../../../config/database import rdb
import ../../../usecases/get_article/get_article_query_interface
import ../../../usecases/get_article/get_article_dto


type GetArticleQuery* = object of IGetArticleQuery

proc new*(_:type GetArticleQuery):GetArticleQuery =
  return GetArticleQuery()


method invoke*(self:GetArticleQuery, articleId:string):Future[GetArticleDto] {.async.} =
  let resOpt = rdb.select(
                "title",
                "description",
                "body",
                "article.created_at as createdAt",
                "author_id as authorId",
                "user.name",
                "user.username as userName",
                "user.image",
              )
              .table("article")
              .join("user", "user.id", "=", "article.author_id")
              .find(articleId, key="article.id")
              .await
  if not resOpt.isSome():
    raise newException(Error404, "invalid article id")
  let res = resOpt.get()

  let articleTagCount = rdb.table("tag_article_map")
                            .where("article_id", "=", articleId)
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
          .where("tag_article_map.article_id", "=", articleId)
          .get(TagDto)
          .await
    else:
      newSeq[TagDto]()

  let article = ArticleDto.new(
    id = articleId,
    title = res["title"].getStr(),
    description = res["description"].getStr(),
    body = res["body"].getStr(),
    createdAt = res["createdAt"].getStr(),
    tags = tags,
  )


  let user = UserDto.new(
    id = res["authorId"].getInt(),
    name = res["name"].getStr(),
    username = res["userName"].getStr(),
    image = res["image"].getStr()
  )

  let dto = GetArticleDto.new(
    article = article,
    user = user
  )
  return dto
