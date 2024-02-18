import std/asyncdispatch
import std/options
import interface_implements
import ./get_user_show_dto
import ../../models/aggregates/user/vo/user_id

interfaceDefs:
  type IGetUserShowQuery*  = object of RootObj
    invoke: proc(self:IGetUserShowQuery, userId:UserId, loginUserId:Option[UserId]):Future[GetUserShowDto]
