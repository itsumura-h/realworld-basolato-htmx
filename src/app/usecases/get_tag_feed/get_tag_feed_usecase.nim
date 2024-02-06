import std/asyncdispatch
import ../../di_container
import ../../models/aggregates/article/vo/tag_name
import ./get_tag_feed_query_interface
import ./get_tag_feed_dto


type GetTagFeedUsecase* = object
  query:IGetTagFeedQuery


proc new*(_:type GetTagFeedUsecase):GetTagFeedUsecase =
  return GetTagFeedUsecase(
    query:di.getTagFeedQuery
  )


proc invoke*(self:GetTagFeedUsecase, tagName:string, page:int):Future[TagFeedDto] {.async.} =
  let tagName = TagName.new(tagName)
  var dto = self.query.invoke(tagName, page).await
  return dto
