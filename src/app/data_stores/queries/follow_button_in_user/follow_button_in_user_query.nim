import std/asyncdispatch
import std/options
import std/json
import allographer/query_builder
from ../../../../config/database import rdb
import ../../../models/dto/follow_button_in_user/follow_button_in_user_query_interface
import ../../../models/dto/follow_button_in_user/follow_button_in_user_dto
import ../../../models/vo/user_id


type FollowButtonInUserQuery* = object of IFollowButtonInUserQuery

proc new*(_:type FollowButtonInUserQuery):FollowButtonInUserQuery =
  return FollowButtonInUserQuery()


method invoke*(self:FollowButtonInUserQuery, userId:UserId, loginUserIdOpt:Option[UserId]):Future[FollowButtonInUserDto] {.async.} =
  let followers = rdb.table("user_user_map")
                      .where("user_id", "=", userId.value)
                      .get()
                      .await

  var isFollowed = false
  if loginUserIdOpt.isSome():
    let loginUserId = loginUserIdOpt.get()
    for follower in followers.items:
      if follower["follower_id"].getStr == loginUserId.value:
        isFollowed = true
        break

  let user = rdb.table("user")
                .find(userId.value)
                .await
  let userId =
    if user.isSome():
      user.get()["id"].getStr
    else:
      ""

  let userName = 
    if user.isSome():
      user.get()["name"].getStr
    else:
      ""

  let dto = FollowButtonInUserDto.new(userId, userName, isFollowed, followers.len)
  return dto
