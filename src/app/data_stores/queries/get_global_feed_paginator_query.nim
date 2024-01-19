import std/asyncdispatch
import std/json
import allographer/query_builder
from ../../../config/database import rdb
import ../../usecases/get_global_feed/get_global_feed_dto


type GetGlobalFeedPaginatorQuery* = object

proc new*(_:type GetGlobalFeedPaginatorQuery):GetGlobalFeedPaginatorQuery =
  return GetGlobalFeedPaginatorQuery()


proc invoke*(self:GetGlobalFeedPaginatorQuery, page:int):Future[PaginatorDto] {.async.} =
  let total = rdb.table("article").count().await
  const display = 5
  let lastPage = total div display
  let hasPages = lastPage > 1
  let paginator = PaginatorDto.new(
    hasPages=hasPages,
    current=page,
    lastPage=lastPage
  )
  return paginator
