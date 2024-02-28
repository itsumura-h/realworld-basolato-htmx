import std/asyncdispatch
import ../../../di_container
import ../../../usecases/get_login_user/get_login_user_query_interface
import ../../../usecases/get_login_user/get_login_user_dto
import ../../../models/aggregates/user/vo/user_id


type MockGetLoginUserQuery*  = object of IGetLoginUserQuery

proc new*(_:type MockGetLoginUserQuery): MockGetLoginUserQuery =
  return MockGetLoginUserQuery()


method invoke*(self: MockGetLoginUserQuery, id:UserId):Future[LoginUserDto] {.async.} =
  return LoginUserDto.new(
    "name-1",
    "Name 1",
    "name1@example.com",
    "bio",
    "imgae"
  )
