import std/asyncdispatch
import ../../../models/dto/tag/tag_query_interface
import ../../../models/dto/tag/tag_dto

  
type MockTagQuery* = object of ITagQuery

proc new*(_:type MockTagQuery): MockTagQuery =
  return MockTagQuery()


method getPopularTagList*(self: MockTagQuery): Future[seq[TagDto]] {.async.} =
  return @[]
