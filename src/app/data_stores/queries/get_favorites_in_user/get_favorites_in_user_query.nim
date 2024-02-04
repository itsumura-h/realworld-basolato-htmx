import std/asyncdispatch
import std/json
import std/options
from ../../../../config/database import rdb
import allographer/query_builder
import ../../../models/aggregates/user/vo/user_id
import ../../../usecases/get_favorites_in_user/get_favorites_in_user_query_interface
import ../../../usecases/get_favorites_in_user/get_favorites_in_user_dto


type GetFavoritesInUserQuery* = object of IGetFavoritesInUserQuery

proc new*(_:type GetFavoritesInUserQuery):GetFavoritesInUserQuery =
  return GetFavoritesInUserQuery()


method invoke*(self:GetFavoritesInUserQuery, userId:UserId):Future[GetFavoritesInUserDto] {.async.} =
  let userData = rdb.table("user").find(userId.value).await.get()
  let user = UserDto.new(userData["id"].getStr())

  let articlesData = rdb.select(
                        "article.id",
                        "article.title",
                        "article.description",
                        "article.author_id",
                        "article.created_at",
                        "author.name",
                        "author.image",
                        )
                        .table("article")
                        .join("user_article_map", "user_article_map.article_id", "=", "article.id")
                        .join("user as author", "author.id", "=", "article.author_id")
                        .join("user as favoriter", "favoriter.id", "=", "user_article_map.user_id")
                        .where("user_article_map.user_id", "=", userId.value)
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
          row["tag_name"].getStr()
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

    let author = AuthorDto.new(
      articleData["author_id"].getStr(),
      articleData["name"].getStr(),
      articleData["image"].getStr(),
    )

    articles.add(
      ArticleDto.new(
        articleData["id"].getStr(),
        articleData["title"].getStr(),
        articleData["description"].getStr(),
        articleData["created_at"].getStr(),
        author,
        tags,
        favoritedUsers
      )
    )

  let dto = GetFavoritesInUserDto.new(
    user,
    articles
  )
  return dto
