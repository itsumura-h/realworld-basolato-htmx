import std/asyncdispatch
import std/json
import std/options
import allographer/query_builder
from ../../../../config/database import rdb
import ../../../errors
import ../../../usecases/get_article_in_feed/get_article_in_feed_query_interface
import ../../../usecases/get_article_in_feed/get_article_in_feed_dto
import ../../../models/vo/article_id
import ../../../models/vo/user_id
import ../get_favorite_button/get_favorite_button_query


type GetArticleInFeedQuery*  = object of IGetArticleInFeedQuery

proc new*(_:type GetArticleInFeedQuery):GetArticleInFeedQuery =
  return GetArticleInFeedQuery()


method invoke*(self:GetArticleInFeedQuery, articleId:ArticleId, loginUserId:Option[UserId]):Future[GetArticleInFeedDto] {.async.} =
  let articleDataOpt = rdb.select(
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
                          .join("user", "user.id", "=", "article.author_id") # get info of author
                          .find(articleId.value, key="article.id")
                          .await

  let articleData = 
    if articleDataOpt.isSome():
      articleDataOpt.get()
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
            "tag.name as tagName",
          )
          .table("tag_article_map")
          .join("tag", "tag.id", "=", "tag_article_map.tag_id")
          .where("tag_article_map.article_id", "=", articleId.value)
          .get(TagDto)
          .await
    else:
      newSeq[TagDto]()

  let getFavoriteButtonQuery = GetFavoriteButtonQuery.new()
  let favoriteButtonDto =
    if loginUserId.isSome():
        getFavoriteButtonQuery.invoke(articleId, loginUserId.get()).await
      else:
        getFavoriteButtonQuery.invoke(articleId).await

  let article = ArticleDto.new(
    id = articleId.value,
    title = articleData["title"].getStr(),
    description = articleData["description"].getStr(),
    body = articleData["body"].getStr(),
    createdAt = articleData["createdAt"].getStr(),
    tags = tags,
    favoriteButtonDto = favoriteButtonDto
  )

  let followerCount = rdb.table("user_user_map")
                        .where("user_id", "=", articleData["authorId"].getStr())
                        .count()
                        .await

  let user = UserDto.new(
    id = articleData["authorId"].getStr(),
    name = articleData["name"].getStr(),
    image = articleData["image"].getStr(),
    followerCount = followerCount,
  )

  let dto = GetArticleInFeedDto.new(
    article = article,
    user = user
  )
  return dto
