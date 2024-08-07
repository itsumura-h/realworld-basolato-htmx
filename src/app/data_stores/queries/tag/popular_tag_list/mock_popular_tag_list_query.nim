import std/asyncdispatch
import ../../../../models/dto/tag/polutar_tag_list_query_interface
import ../../../../models/dto/tag/tag_dto


type MockPopularTagListQuery* = object of IPopularTagListQuery

proc new*(_:type MockPopularTagListQuery): MockPopularTagListQuery =
  return MockPopularTagListQuery()


method invoke*(self: MockPopularTagListQuery): Future[seq[TagDto]] {.async.} =
  return @[]
