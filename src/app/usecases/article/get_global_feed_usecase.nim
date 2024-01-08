import std/asyncdispatch
import std/json
import ../../errors
import ../../di_container
import ./article_query_interface


type GetGlobalFeedUsecase* = ref object
  query:IArticleQuery


proc new*(_:type GetGlobalFeedUsecase):GetGlobalFeedUsecase =
  return GetGlobalFeedUsecase(
    query:di.articleQuery
  )


proc invoke*(self:GetGlobalFeedUsecase):Future[seq[JsonNode]] {.async.} =
  return self.query.getGlobalFeed().await
