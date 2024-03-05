import std/asyncdispatch
import ../../di_container
import ../../models/vo/user_id
import ./get_articles_in_user_query_interface
import ./get_articles_in_user_dto


type GetArticlesInUserUsecase*  = object
  query:IGetArticlesInUserQuery

proc new*(_:type GetArticlesInUserUsecase):GetArticlesInUserUsecase =
  return GetArticlesInUserUsecase(
    query:di.getArticlesInUserQuery
  )


proc invoke*(self:GetArticlesInUserUsecase, userId:string, loginUserId:string):Future[GetArticlesInUserDto] {.async.} =
  let userId = UserId.new(userId)
  let loginUserId = UserId.new(loginUserId)
  let dto = self.query.invoke(userId, loginUserId).await
  return dto
