import std/asyncdispatch
import ../../di_container
import ./get_your_feed_query_interface
import ./your_feed_dto
import ../../models/vo/user_id


type GetYourFeedUsecase* = object
  query:IGetYourFeedQuery


proc new*(_:type GetYourFeedUsecase):GetYourFeedUsecase =
  return GetYourFeedUsecase(query: di.getYourFeedQuery)


proc invoke*(self:GetYourFeedUsecase, userId:string, page:int):Future[YourFeedDto] {.async.} =
  let userId = UserId.new(userId)
  let dto = self.query.invoke(userId, page).await
  return dto
