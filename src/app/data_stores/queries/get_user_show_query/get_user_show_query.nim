import std/asyncdispatch
import std/options
import std/json
import allographer/query_builder
from ../../../../config/database import rdb
import ../../../models/vo/user_id
import ../../../usecases/get_user_show/get_user_show_query_interface
import ../../../usecases/get_user_show/get_user_show_dto


type GetUserShowQuery*  = object of IGetUserShowQuery

proc new*(_:type GetUserShowQuery):GetUserShowQuery =
  return GetUserShowQuery()


method invoke*(self:GetUserShowQuery, userId:UserId, loginUserId:Option[UserId]):Future[GetUserShowDto] {.async.} =
  let userOpt = rdb.table("user")
                    .find(userId.value)
                    .await
  let user = userOpt.get()

  let dto = GetUserShowDto.new(
    user["id"].getStr(),
    user["name"].getStr(),
    user["bio"].getStr(),
    user["image"].getStr(),
  )
  return dto
