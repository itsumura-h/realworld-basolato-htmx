import std/asyncdispatch
import ../../../usecases/get_favorite_button_in_user/get_favorite_button_in_user_query_interface
import ../../../usecases/get_favorite_button_in_user/favorite_button_in_user_dto
import ../../../models/vo/article_id
import ../../../models/vo/user_id

type MockGetFavoriteButtonInUserQuery* = object of IGetFavoriteButtonInUserQuery

proc new*(_:type MockGetFavoriteButtonInUserQuery): MockGetFavoriteButtonInUserQuery =
  return MockGetFavoriteButtonInUserQuery()
