import std/asyncdispatch
import std/json
from ../../../config/database import testRdb
import ../../usecases/article/article_query_interface


type MockArticleQuery* = ref object

proc new*(_:type MockArticleQuery):MockArticleQuery =
  return MockArticleQuery()


proc getGlobalFeed(self:MockArticleQuery):Future[seq[JsonNode]] {.async.} =
  return newSeq[JsonNode]()



proc toInterface*(self:MockArticleQuery):IArticleQuery =
  return (
    getGlobalFeed:proc():Future[seq[JsonNode]] = self.getGlobalFeed(),
  )
