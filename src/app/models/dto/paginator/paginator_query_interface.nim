import std/asyncdispatch
import interface_implements
import ./paginator_dto

interfaceDefs:
  type IPaginatorQuery* = object of RootObj
    invoke: proc(self:IPaginatorQuery, page:int, display:int): Future[PaginatorDto]
