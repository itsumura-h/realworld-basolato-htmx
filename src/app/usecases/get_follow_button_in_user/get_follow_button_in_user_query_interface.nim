import std/asyncdispatch
import std/options
import interface_implements
import ./follow_button_in_user_dto
import ../../models/vo/user_id


interfaceDefs:
  type IGetFollowButtonInUserQuery* = object of Rootobj
    invoke: proc(self:IGetFollowButtonInUserQuery, userId:UserId, loginUserId:Option[UserId]):Future[FollowButtonInUserDto]
