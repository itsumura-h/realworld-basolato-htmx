import std/asyncdispatch
import interface_implements
import ../../models/aggregates/user/vo/user_id
import ./get_favorites_in_user_dto


interfaceDefs:
  type IGetFavoritesInUserQuery*  = object of RootObj
    invoke*: proc (self: IGetFavoritesInUserQuery, userId:UserId): Future[GetFavoritesInUserDto]
  