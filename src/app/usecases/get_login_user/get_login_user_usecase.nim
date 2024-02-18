import std/asyncdispatch
import ../../di_container
import ../../models/aggregates/user/vo/user_id
import ./get_login_user_dto
import ./get_login_user_query_interface

type GetLoginUserUsecase*  = object
  query:IGetLoginUserQuery

proc init*(_:type GetLoginUserUsecase): GetLoginUserUsecase =
  return GetLoginUserUsecase(
    query: di.getLoginUserQuery
  )


proc invoke*(self: GetLoginUserUsecase, userId:string):Future[LoginUserDto] {.async.} =
  let userId = UserId.init(userId)
  let dto = self.query.invoke(userId).await
  return dto
