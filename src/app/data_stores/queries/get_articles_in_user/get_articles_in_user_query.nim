import std/asyncdispatch
import std/json
import allographer/query_builder
from ../../../../config/database import rdb
import ../../../models/aggregates/user/vo/user_id
import ../../../usecases/get_articles_in_user/get_articles_in_user_query_interface
import ../../../usecases/get_articles_in_user/get_articles_in_user_dto


type GetArticlesInUserQuery*  = object of IGetArticlesInUserQuery

proc init*(_:type GetArticlesInUserQuery):GetArticlesInUserQuery =
  return GetArticlesInUserQuery()


method invoke*(self:GetArticlesInUserQuery, userId:UserId):Future[GetArticlesInUserDto] {.async.} =
  let articlesData = rdb.select(
                      "article.id",
                      "article.title",
                      "article.description",
                      "article.author_id",
                      "article.created_at",
                      "user.name",
                      "user.image",
                      )
                      .table("article")
                      .join("user", "user.id", "=", "article.author_id")
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
        TagDto.init(
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
        FavoritedUserDto.init(
          row["id"].getStr(),
        )
      )

    let author = AuthorDto.init(
      articleData["author_id"].getStr(),
      articleData["name"].getStr(),
      articleData["image"].getStr(),
    )

    for articleData in articlesData:
      articles.add(
        ArticleDto.init(
          articleData["id"].getStr(),
          articleData["title"].getStr(),
          articleData["description"].getStr(),
          articleData["created_at"].getStr(),
          author,
          tags,
          favoritedUsers
        )
      )

  let dto = GetArticlesInUserDto.init(
    articles
  )
  return dto
