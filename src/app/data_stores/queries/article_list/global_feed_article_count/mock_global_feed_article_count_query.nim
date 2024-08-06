import std/asyncdispatch
import ../../../../models/dto/article_list/article_count_query_interface


type MockGlobalFeedArticleCountQuery* = object of IGlobalFeedArticleCountQuery

proc new*(_:type MockGlobalFeedArticleCountQuery):MockGlobalFeedArticleCountQuery =
  return MockGlobalFeedArticleCountQuery()


method invoke*(self:MockGlobalFeedArticleCountQuery):Future[int] {.async.} =
  return 100
