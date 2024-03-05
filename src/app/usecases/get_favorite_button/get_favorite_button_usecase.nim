import std/asyncdispatch
import ../../di_container
import ../../models/vo/article_id
import ../../models/vo/user_id
import ./favorite_button_dto
import ./get_favorite_button_query_interface


type GetFavoriteButtonUsecase* = object
  query:IGetFavoriteButtonQuery

proc new*(_:type GetFavoriteButtonUsecase):GetFavoriteButtonUsecase =
  return GetFavoriteButtonUsecase(
    query: di.getFavoriteButtonQuery
  )


proc invoke*(self:GetFavoriteButtonUsecase, articleId:string, userId:string):Future[FavoriteButtonDto] {.async.} =
  let articleId = ArticleId.new(articleId)
  let userId = UserId.new(userId)
  let dto = self.query.invoke(articleId, userId).await
  return dto
