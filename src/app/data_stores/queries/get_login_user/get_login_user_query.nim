import std/asyncdispatch
import std/options
import std/json
import allographer/query_builder
from ../../../../config/database import rdb
import ../../../errors
import ../../../usecases/get_login_user/get_login_user_query_interface
import ../../../usecases/get_login_user/get_login_user_dto
import ../../../models/aggregates/user/vo/user_id

type GetLoginUserQuery* = object of IGetLoginUserQuery

proc new*(_:type GetLoginUserQuery): GetLoginUserQuery =
  return GetLoginUserQuery()


method invoke*(self:GetLoginUserQuery, userId:UserId):Future[LoginUserDto] {.async.} =
  let userOpt = rdb.table("user")
                    .find(userId.value)
                    .await
  if not userOpt.isSome:
    raise newException(IdNotFoundError, "User not found")

  let userData = userOpt.get()

  let dto = LoginUserDto.new(
    userData["name"].getStr(),
    userData["email"].getStr(),
    userData["bio"].getStr(),
    userData["image"].getStr(),
  )
  return dto
