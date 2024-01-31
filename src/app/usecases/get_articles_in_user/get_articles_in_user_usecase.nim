import std/asyncdispatch
import std/strformat
import std/options
import ../../di_container
import ../../errors
import ../../models/aggregates/user/vo/user_id
import ../../models/aggregates/user/user_service
import ./get_articles_in_user_dto
import ./get_articles_in_user_query_interface


type GetArticlesInUserUsecase* = object
  service:UserService
  query:IGetArticlesInUserQuery


proc new*(_:type GetArticlesInUserUsecase):GetArticlesInUserUsecase =
  return GetArticlesInUserUsecase(
    service:UserService.new(),
    query: di.getArticlesInUserQuery
  )


proc invoke*(self:GetArticlesInUserUsecase, userId:string, loginUserId:Option[string]):Future[GetArticlesInUserDto] {.async.} =
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
