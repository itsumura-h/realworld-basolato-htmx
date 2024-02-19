import std/asyncdispatch
import std/strformat
import std/options
import ../../di_container
import ../../errors
import ../../models/aggregates/user/vo/user_id
import ../../models/aggregates/user/user_service
import ./get_user_show_dto
import ./get_user_show_query_interface


type GetUserShowUsecase*  = object
  service:UserService
  query:IGetUserShowQuery


proc new*(_:type GetUserShowUsecase):GetUserShowUsecase =
  return GetUserShowUsecase(
    service:UserService.new(),
    query: di.getUserShowQuery
  )


proc invoke*(self:GetUserShowUsecase, userId:string, loginUserId:Option[string]):Future[GetUserShowDto] {.async.} =
  let userId = UserId.new(userId)
  if not self.service.isExistsUser(userId).await:
    raise newException(IdNotFoundError, &"user id {userId} is not found")

  let loginUserId =
    if loginUserId.isSome():
      UserId.new(loginUserId.get()).some()
    else:
      none(UserId)

  let dto = self.query.invoke(userId, loginUserId).await
  return dto
