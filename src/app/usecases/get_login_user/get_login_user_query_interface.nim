import std/asyncdispatch
import interface_implements
import ./get_login_user_dto
import ../../models/aggregates/user/vo/user_id

interfaceDefs:
  type IGetLoginUserQuery*  = object of RootObj
    invoke: proc(self:IGetLoginUserQuery, id: UserId): Future[LoginUserDto]
