import std/asyncdispatch
import allographer/query_builder
from ../../../../../config/database import rdb
import ../../../../models/dto/article_list/tag_feed_article_count_query_interface

type TagFeedArticleCountQuery* = object of ITagFeedArticleCountQuery

proc new*(_:type TagFeedArticleCountQuery): TagFeedArticleCountQuery =
  return TagFeedArticleCountQuery()


method invoke*(self:TagFeedArticleCountQuery,tagId:string,): Future[int]  {.async.} =
  let count = rdb.table("tag_article_map")
            .where("tag_article_map.tag_id", "=", tagId)
            .count()
            .await
  return count
