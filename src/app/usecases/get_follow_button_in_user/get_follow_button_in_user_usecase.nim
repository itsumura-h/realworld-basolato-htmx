import std/asyncdispatch
import std/options
import ../../models/vo/user_id
import ./get_follow_button_in_user_query_interface
import ./follow_button_in_user_dto
import ../../di_container

type GetFollowButtonInUserUsecase* = object
  query: IGetFollowButtonInUserQuery

proc new*(_:type GetFollowButtonInUserUsecase): GetFollowButtonInUserUsecase =
  return GetFollowButtonInUserUsecase(
    query: di.getFollowButtonInUserQuery
  )


proc invoke*(self:GetFollowButtonInUserUsecase, userId: string, loginUserId: string):Future[FollowButtonInUserDto] {.async.} =
  let userId = UserId.new(userId)
  let loginUserId =
    if loginUserId.len == 0:
      none(UserId)
    else:
      UserId.new(loginUserId).some()

  let dto = self.query.invoke(userId, loginUserId).await
  return dto
