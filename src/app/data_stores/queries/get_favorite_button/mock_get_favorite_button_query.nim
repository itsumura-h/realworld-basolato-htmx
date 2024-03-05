import std/asyncdispatch
import ../../../usecases/get_favorite_button/get_favorite_button_query_interface
import ../../../usecases/get_favorite_button/favorite_button_dto
import ../../../models/vo/article_id
import ../../../models/vo/user_id

type MockGetFavoriteButtonQuery* = object of IGetFavoriteButtonQuery

proc new*(_:type MockGetFavoriteButtonQuery): MockGetFavoriteButtonQuery =
  return MockGetFavoriteButtonQuery()


method invoke*(self:MockGetFavoriteButtonQuery, articleId:ArticleId, userId:UserId):Future[FavoriteButtonDto] {.async.} =
  return FavoriteButtonDto.new(
    articleId.value,
    5,
    true,
    true
  )


method invoke*(self:MockGetFavoriteButtonQuery, articleId:ArticleId):Future[FavoriteButtonDto] {.async.} =
  return FavoriteButtonDto.new(
    articleId.value,
    5,
    false,
    false
  )
