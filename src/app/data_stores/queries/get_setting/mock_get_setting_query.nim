import std/asyncdispatch
import ../../../di_container
import ../../../usecases/get_setting/get_setting_query_interface
import ../../../usecases/get_setting/get_setting_dto
import ../../../models/aggregates/user/vo/user_id


type MockGetSettingQuery* = object of IGetSettingQuery

proc new*(_:type MockGetSettingQuery): MockGetSettingQuery =
  return MockGetSettingQuery()


method invoke*(self: MockGetSettingQuery, id:UserId):Future[GetSettingDto] {.async.} =
  return GetSettingDto.new(
    "Namw 1",
    "name1@example.com",
    "bio",
    "imgae"
  )
