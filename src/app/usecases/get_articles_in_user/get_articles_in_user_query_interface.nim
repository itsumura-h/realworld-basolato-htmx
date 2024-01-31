import std/asyncdispatch
import std/options
import interface_implements
import ./get_articles_in_user_dto
import ../../models/aggregates/user/vo/user_id

interfaceDefs:
  type IGetArticlesInUserQuery* = object of RootObj
    invoke: proc(self:IGetArticlesInUserQuery, userId:UserId, loginUserId:Option[UserId]):Future[GetArticlesInUserDto]
