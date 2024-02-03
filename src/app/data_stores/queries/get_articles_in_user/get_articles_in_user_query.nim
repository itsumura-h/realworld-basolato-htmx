import std/asyncdispatch
import ../../../models/aggregates/user/vo/user_id
import ../../../usecases/get_articles_in_user/get_articles_in_user_query_interface
import ../../../usecases/get_articles_in_user/get_articles_in_user_dto


type GetArticlesInUserQuery* = object of IGetArticlesInUserQuery

proc new*(_:type GetArticlesInUserQuery):GetArticlesInUserQuery =
  return GetArticlesInUserQuery()


method invoke*(self:GetArticlesInUserQuery, userId:UserId):Future[GetArticlesInUserQueryDto] {.async.} =
  discard
