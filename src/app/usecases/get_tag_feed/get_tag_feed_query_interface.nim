import std/asyncdispatch
import interface_implements
import ../../models/aggregates/article/vo/tag_name
import ./get_tag_feed_dto

interfaceDefs:
  type IGetTagFeedQuery* = object of RootObj
    invoke*: proc(self:IGetTagFeedQuery, tagName:TagName, page:int):Future[TagFeedDto]
