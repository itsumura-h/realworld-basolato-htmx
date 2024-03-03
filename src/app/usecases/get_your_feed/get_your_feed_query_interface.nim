import std/asyncdispatch
import interface_implements
import ../../models/vo/user_id
import ./your_feed_dto


interfaceDefs:
  type IGetYourFeedQuery* = object of RootObj
    invoke: proc(self:IGetYourFeedQuery, userId: UserId, page:int):Future[YourFeedDto]
