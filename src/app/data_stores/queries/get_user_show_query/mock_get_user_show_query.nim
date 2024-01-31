import ../../../models/aggregates/user/vo/user_id
import ../../../usecases/get_user_show/get_user_show_query_interface
import ../../../usecases/get_user_show/get_user_show_dto


type MockGetUserShowQuery* = object of IGetUserShowQuery

proc new*(_:type MockGetUserShowQuery):MockGetUserShowQuery =
  return MockGetUserShowQuery()


method invoke*(self:MockGetUserShowQuery, userId:UserId):GetUserShowDto =
  return GetUserShowDto()
