import std/asyncdispatch
import std/json
import allographer/query_builder
from ../../../../../config/database import rdb
import ../../../../models/dto/article/global_feed_article_list_query_interface
import ../../../../models/dto/article/article_dto


type MockGlobalFeedArticleListQuery* = object of IGlobalFeedArticleListQuery

proc new*(_:type MockGlobalFeedArticleListQuery):MockGlobalFeedArticleListQuery =
  return MockGlobalFeedArticleListQuery()


method invoke*(
  self:MockGlobalFeedArticleListQuery,
  offset:int,
  display:int
):Future[seq[ArticleDto]] {.async.} =
  discard
