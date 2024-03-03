import std/asyncdispatch
import std/json
import std/options
import allographer/query_builder
import ../../../errors
from ../../../../config/database import rdb
import ../../../models/vo/user_id
import ../../../usecases/get_articles_in_user/get_articles_in_user_query_interface
import ../../../usecases/get_articles_in_user/get_articles_in_user_dto


type GetArticlesInUserQuery*  = object of IGetArticlesInUserQuery

proc new*(_:type GetArticlesInUserQuery):GetArticlesInUserQuery =
  return GetArticlesInUserQuery()


method invoke*(self:GetArticlesInUserQuery, userId:UserId):Future[GetArticlesInUserDto] {.async.} =
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
    
    var favoritedUsers:seq[FavoritedUserDto] 
    let favoritedUsersData = rdb.table("user_article_map")
                                .join("user", "user.id", "=", "user_article_map.user_id")
                                .where("user_article_map.article_id", "=", articleData["id"].getStr())
                                .get()
                                .await
    for row in favoritedUsersData:
      favoritedUsers.add(
        FavoritedUserDto.new(
          row["id"].getStr(),
        )
      )

    for articleData in articlesData:
      articles.add(
        ArticleDto.new(
          articleData["id"].getStr(),
          articleData["title"].getStr(),
          articleData["description"].getStr(),
          articleData["created_at"].getStr(),
          tags,
          favoritedUsers
        )
      )

  let dto = GetArticlesInUserDto.new(
    articles,
    author
  )
  return dto
