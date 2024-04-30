import std/asyncdispatch
import std/options
import interface_implements
import ./follow_button_in_user_dto
import ../../vo/user_id


interfaceDefs:
  type IFollowButtonInUserQuery* = object of Rootobj
    invoke: proc(self:IFollowButtonInUserQuery, userId:UserId, loginUserId:Option[UserId]):Future[FollowButtonInUserDto]
