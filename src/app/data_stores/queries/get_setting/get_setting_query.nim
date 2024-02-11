import std/asyncdispatch
import std/options
import std/json
import allographer/query_builder
from ../../../../config/database import rdb
import ../../../errors
import ../../../usecases/get_setting/get_setting_query_interface
import ../../../usecases/get_setting/get_setting_dto
import ../../../models/aggregates/user/vo/user_id

type GetSettingQuery* = object of IGetSettingQuery

proc new*(_:type GetSettingQuery): GetSettingQuery =
  return GetSettingQuery()


method invoke*(self:GetSettingQuery, userId:UserId):Future[GetSettingDto] {.async.} =
  let userOpt = rdb.table("user")
                    .find(userId.value)
                    .await
  if not userOpt.isSome:
    raise newException(IdNotFoundError, "User not found")

  let userData = userOpt.get()

  let dto = GetSettingDto.new(
    userData["name"].getStr(),
    userData["email"].getStr(),
    userData["bio"].getStr(),
    userData["image"].getStr(),
  )
  return dto
