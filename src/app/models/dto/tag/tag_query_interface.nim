
import std/asyncdispatch
import interface_implements
import ./tag_dto

interfaceDefs:
  type ITagQuery* = object of RootObj
    getPopularTagList*: proc(self: ITagQuery): Future[seq[TagDto]]
