import std/asyncdispatch
import ../../../usecases/get_follow_button_in_user/get_follow_button_in_user_query_interface
import ../../../usecases/get_follow_button_in_user/follow_button_in_user_dto
import ../../../models/vo/user_id

type MockGetFollowButtonInUserQuery* = object of IGetFollowButtonInUserQuery

proc new*(_:type MockGetFollowButtonInUserQuery):MockGetFollowButtonInUserQuery =
  return MockGetFollowButtonInUserQuery()


method invoke*(self:MockGetFollowButtonInUserQuery, userId:UserId, loginUserId:UserId):Future[FollowButtonInUserDto] {.async.} =
  discard
