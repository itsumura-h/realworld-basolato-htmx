import std/asyncdispatch
import ../../di_container
import ./favorite_button_in_user_dto
import ./get_favorite_button_in_user_query_interface
import ../../models/vo/article_id
import ../../models/vo/user_id


type GetFavoriteButtonInUserUsecase* = object
  query:IGetFavoriteButtonInUserQuery

proc new*(_:type GetFavoriteButtonInUserUsecase):GetFavoriteButtonInUserUsecase =
  return GetFavoriteButtonInUserUsecase(
    query: di.getFavoriteButtonInUserQuery
  )


proc invoke*(self:GetFavoriteButtonInUserUsecase, articleId:string, userId:string):Future[FavoriteButtonInUserDto] {.async.} =
  let articleId = ArticleId.new(articleId)
  let userId = UserId.new(userId)
  let dto = self.query.invoke(articleId, userId).await
  return dto
