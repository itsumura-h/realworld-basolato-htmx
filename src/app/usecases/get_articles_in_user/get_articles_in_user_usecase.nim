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


proc invoke*(self:GetArticlesInUserUsecase, userId:string):Future[GetArticlesInUserDto] {.async.} =
  let userId = UserId.new(userId)
  let dto = self.query.invoke(userId).await
  return dto
