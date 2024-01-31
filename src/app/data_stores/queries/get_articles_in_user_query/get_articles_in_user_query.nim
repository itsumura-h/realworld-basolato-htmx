import std/asyncdispatch
import std/options
import std/json
import allographer/query_builder
from ../../../../config/database import rdb
import ../../../models/aggregates/user/vo/user_id
import ../../../usecases/get_articles_in_user/get_articles_in_user_query_interface
import ../../../usecases/get_articles_in_user/get_articles_in_user_dto


type GetArticlesInUserQuery* = object of IGetArticlesInUserQuery

proc new*(_:type GetArticlesInUserQuery):GetArticlesInUserQuery =
  return GetArticlesInUserQuery()


method invoke*(self:GetArticlesInUserQuery, userId:UserId, loginUserId:Option[UserId]):Future[GetArticlesInUserDto] {.async.} =
  let userOpt = rdb.table("user")
                    .find(userId.value)
                    .await
  let user = userOpt.get()

  let followerCount = rdb.table("user_user_map")
                          .where("user_id", "=", userId.value)
                          .count()
                          .await

  var isFollowed = false
  if loginUserId.isSome():
    let follow = rdb.table("user_user_map")
                    .where("user_id", "=", userId.value)
                    .where("follower_id", "=", loginUserId.get().value)
                    .count()
                    .await
    isFollowed = follow > 0


  let dto = GetArticlesInUserDto.new(
    user["id"].getStr(),
    user["name"].getStr(),
    user["bio"].getStr(),
    user["image"].getStr(),
    isFollowed,
    followerCount
  )
  return dto
