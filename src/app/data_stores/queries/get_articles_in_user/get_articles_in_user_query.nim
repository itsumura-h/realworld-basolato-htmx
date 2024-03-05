import std/asyncdispatch
import std/json
import std/options
import allographer/query_builder
import ../../../errors
from ../../../../config/database import rdb
import ../../../models/vo/article_id
import ../../../models/vo/user_id
import ../../../usecases/get_articles_in_user/get_articles_in_user_query_interface
import ../../../usecases/get_articles_in_user/get_articles_in_user_dto
import ../get_favorite_button/get_favorite_button_query


type GetArticlesInUserQuery*  = object of IGetArticlesInUserQuery

proc new*(_:type GetArticlesInUserQuery):GetArticlesInUserQuery =
  return GetArticlesInUserQuery()


method invoke*(self:GetArticlesInUserQuery, userId:UserId, loginUserId:UserId):Future[GetArticlesInUserDto] {.async.} =
  let authorOpt = rdb.table("user")
                    .where("id", "=", userId.value)
                    .first()
                    .await
  if not authorOpt.isSome():
    raise newException(IdNotFoundError, "Author not found")
  let authorData = authorOpt.get()

  let author = AuthorDto.new(
    authorData["id"].getStr(),
    authorData["name"].getStr(),
    authorData["image"].getStr(),
  )

  let articlesData = rdb.select(
                      "article.id",
                      "article.title",
                      "article.description",
                      "article.author_id",
                      "article.created_at",
                      )
                      .table("article")
                      .where("author_id", "=", userId.value)
                      .get()
                      .await

  var articles:seq[ArticleDto]
  for articleData in articlesData:
    var tags:seq[TagDto] 
    let tagsData = rdb.table("tag")
                    .join("tag_article_map", "tag_article_map.tag_id", "=", "tag.id")
                    .where("tag_article_map.article_id", "=", articleData["id"].getStr())
                    .get()
                    .await
    for row in tagsData:
      tags.add(
        TagDto.new(
          row["tag_id"].getStr()
        )
      )
    
    let getFavoriteButtonQuery = GetFavoriteButtonQuery.new()
    let articleId = ArticleId.new(articleData["id"].getStr())
    let favoriteButtonDto = getFavoriteButtonQuery.invoke(articleId, loginUserId).await

    articles.add(
      ArticleDto.new(
        articleData["id"].getStr(),
        articleData["title"].getStr(),
        articleData["description"].getStr(),
        articleData["created_at"].getStr(),
        tags,
        favoriteButtonDto,
      )
    )

  let dto = GetArticlesInUserDto.new(
    articles,
    author
  )
  return dto
