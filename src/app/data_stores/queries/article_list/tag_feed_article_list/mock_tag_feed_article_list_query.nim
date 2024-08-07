import std/asyncdispatch
import ../../../../models/dto/article_list/article_list_dto
import ../../../../models/dto/article_list/tag_feed_article_list_query_interface

type MockTagFeedArticleListQuery* = object of ITagFeedArticleListQuery

proc new*(_:type MockTagFeedArticleListQuery): MockTagFeedArticleListQuery =
  return MockTagFeedArticleListQuery()


method invoke*(self:MockTagFeedArticleListQuery,tagId:string,offset:int,display:int): Future[seq[ArticleDto]]  {.async.} =
  return @[]
