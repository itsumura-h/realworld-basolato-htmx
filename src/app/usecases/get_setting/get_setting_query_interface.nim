import std/asyncdispatch
import interface_implements
import ./get_setting_dto
import ../../models/aggregates/user/vo/user_id

interfaceDefs:
  type IGetSettingQuery* = object of RootObj
    invoke: proc(self:IGetSettingQuery, id: UserId): Future[GetSettingDto]
