import std/asyncdispatch
import interface_implements
import ./user_dto

interfaceDefs:
  type IUserQuery* = object of RootObj
    invoke: proc(self: IUserQuery, userId: string): Future[UserDto]
