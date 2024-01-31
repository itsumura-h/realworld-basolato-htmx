import ../../../models/aggregates/user/vo/user_id
import ../../../usecases/get_articles_in_user/get_articles_in_user_query_interface
import ../../../usecases/get_articles_in_user/get_articles_in_user_dto


type MockGetArticlesInUserQuery* = object of IGetArticlesInUserQuery

proc new*(_:type MockGetArticlesInUserQuery):MockGetArticlesInUserQuery =
  return MockGetArticlesInUserQuery()


method invoke*(self:MockGetArticlesInUserQuery, userId:UserId):GetArticlesInUserDto =
  return GetArticlesInUserDto()
