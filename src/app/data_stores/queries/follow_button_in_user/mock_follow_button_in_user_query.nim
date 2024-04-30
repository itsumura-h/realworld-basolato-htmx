import std/asyncdispatch
import std/options
import ../../../models/dto/follow_button_in_user/follow_button_in_user_query_interface
import ../../../models/dto/follow_button_in_user/follow_button_in_user_dto
import ../../../models/vo/user_id


type MockFollowButtonInUserQuery* = object of IFollowButtonInUserQuery

proc new*(_:type MockFollowButtonInUserQuery):MockFollowButtonInUserQuery =
  return MockFollowButtonInUserQuery()


method invoke*(self:MockFollowButtonInUserQuery, userId:UserId, loginUserIdOpt:Option[UserId]):Future[FollowButtonInUserDto] {.async.} =
  discard
