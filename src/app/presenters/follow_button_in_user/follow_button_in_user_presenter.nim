import std/asyncdispatch
import std/options
import ../../models/dto/follow_button_in_user/follow_button_in_user_query_interface
import ../../models/vo/user_id
import ../../http/views/components/user/follow_button/follow_button_view_model
import ../../di_container


type FollowButtonInUserPresenter* = object
  followButtonInUserQuery:IFollowButtonInUserQuery

proc new*(_:type FollowButtonInUserPresenter):FollowButtonInUserPresenter =
  return FollowButtonInUserPresenter(
    followButtonInUserQuery: di.followButtonInUserQuery
  )


proc invoke*(self:FollowButtonInUserPresenter, userId:string, loginUserId:string):Future[FollowButtonViewModel] {.async.} =
  let userId = UserId.new(userId)
  let loginUserId = UserId.new(loginUserId).some()
  let followButtonInUserDto = self.followButtonInUserQuery.invoke(userId, loginUserId).await
  let viewModel = FollowButtonViewModel.new(followButtonInUserDto)
  return viewModel
