import std/asyncdispatch
import std/options
import std/json
import allographer/query_builder
from ../../../../config/database import rdb
import ../../../usecases/get_favorite_button_in_user/get_favorite_button_in_user_query_interface
import ../../../usecases/get_favorite_button_in_user/favorite_button_in_user_dto
import ../../../models/vo/article_id
import ../../../models/vo/user_id

type GetFavoriteButtonInUserQuery* = object of IGetFavoriteButtonInUserQuery

proc new*(_:type GetFavoriteButtonInUserQuery): GetFavoriteButtonInUserQuery =
  return GetFavoriteButtonInUserQuery()


method invoke*(self:GetFavoriteButtonInUserQuery, articleId:ArticleId, userId:UserId):Future[FavoriteButtonInUserDto] {.async.} =
  let favoriteCount = rdb.table("user_article_map")
                          .where("article_id", "=", articleId.value)
                          .count()
                          .await

  let isFavoriteOpt = rdb.table("user_article_map")
                        .where("article_id", "=", articleId.value)
                        .where("user_id", "=", userId.value)
                        .first()
                        .await
  let isFavorited = isFavoriteOpt.isSome()

  let articleDataOpt = rdb.table("article")
                          .find(articleId.value)
                          .await
  let articleData = articleDataOpt.get()
  let isCurrentUser = articleData["author_id"].getStr == userId.value

  let dto = FavoriteButtonInUserDto.new(isFavorited, articleId.value, isCurrentUser, favoriteCount)
  return dto
