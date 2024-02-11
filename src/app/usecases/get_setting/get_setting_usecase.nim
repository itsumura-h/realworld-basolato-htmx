import std/asyncdispatch
import ../../di_container
import ../../models/aggregates/user/vo/user_id
import ./get_setting_dto
import ./get_setting_query_interface

type GetSettingUsecase* = object
  query:IGetSettingQuery

proc new*(_:type GetSettingUsecase): GetSettingUsecase =
  return GetSettingUsecase(
    query: di.getSettingQuery
  )


proc invoke*(self: GetSettingUsecase, userId:string):Future[GetSettingDto] {.async.} =
  let userId = UserId.new(userId)
  let dto = self.query.invoke(userId).await
  return dto
