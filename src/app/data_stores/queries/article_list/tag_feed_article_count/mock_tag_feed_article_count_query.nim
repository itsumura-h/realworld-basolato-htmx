import std/asyncdispatch
import ../../../../models/dto/article_list/tag_feed_article_count_query_interface

type MockTagFeedArticleCountQuery* = object of ITagFeedArticleCountQuery

proc new*(_:type MockTagFeedArticleCountQuery): MockTagFeedArticleCountQuery =
  return MockTagFeedArticleCountQuery()


method invoke*(self:MockTagFeedArticleCountQuery,tagId:string,): Future[int]  {.async.} =
  return 0
