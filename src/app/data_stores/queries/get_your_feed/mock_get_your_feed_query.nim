import std/asyncdispatch
import ../../../usecases/get_your_feed/get_your_feed_query_interface
import ../../../usecases/get_your_feed/your_feed_dto
import../../../models/aggregates/user/vo/user_id


type MockGetYourFeedQuery* = object of IGetYourFeedQuery

proc new*(_:type MockGetYourFeedQuery):MockGetYourFeedQuery =
  return MockGetYourFeedQuery()


method invoke*(self:MockGetYourFeedQuery, userId:UserId, page:int):Future[YourFeedDto] {.async.} =
  discard
