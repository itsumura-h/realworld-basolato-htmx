import std/asyncdispatch
import ../../../models/dto/paginator/paginator_dto
import ../../../models/dto/paginator/paginator_query_interface

type MockGlobalFeedPaginatorQuery* = object of IPaginatorQuery

proc new*(_:type MockGlobalFeedPaginatorQuery):MockGlobalFeedPaginatorQuery =
  return MockGlobalFeedPaginatorQuery()


method invoke(self:MockGlobalFeedPaginatorQuery, page:int, display:int):Future[PaginatorDto] {.async.} =
  discard
