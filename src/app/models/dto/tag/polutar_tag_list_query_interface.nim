
import std/asyncdispatch
import interface_implements
import ./tag_dto

interfaceDefs:
  type IPopularTagListQuery* = object of RootObj
    invoke*: proc(self: IPopularTagListQuery): Future[seq[TagDto]]
