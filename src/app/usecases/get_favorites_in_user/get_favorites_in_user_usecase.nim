import std/asyncdispatch
import ../../di_container
import ./get_favorites_in_user_query_interface
import ./get_favorites_in_user_dto
import ../../models/aggregates/user/vo/user_id


type GetFavoritesInUserUsecase*  = object
  query: IGetFavoritesInUserQuery

proc new*(_:type GetFavoritesInUserUsecase):GetFavoritesInUserUsecase =
  return GetFavoritesInUserUsecase(
    query: di.getFavoritesInUserQuery
  )


proc invoke*(self:GetFavoritesInUserUsecase, userId: string): Future[GetFavoritesInUserDto] {.async.} =
  let userId = UserId.new(userId)
  let dto = self.query.invoke(userId).await
  return dto
