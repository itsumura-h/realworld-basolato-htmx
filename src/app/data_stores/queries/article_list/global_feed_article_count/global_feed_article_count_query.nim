import std/asyncdispatch
import allographer/query_builder
from ../../../../../config/database import rdb
import ../../../../models/dto/article_list/global_feed_article_count_query_interface


type GlobalFeedArticleCountQuery* = object of IGlobalFeedArticleCountQuery

proc new*(_:type GlobalFeedArticleCountQuery):GlobalFeedArticleCountQuery =
  return GlobalFeedArticleCountQuery()


method invoke*(self:GlobalFeedArticleCountQuery):Future[int] {.async.} =
  let totalCount = rdb.table("article").count().await
  return totalCount
