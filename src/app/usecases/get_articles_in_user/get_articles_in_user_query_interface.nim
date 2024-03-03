import std/asyncdispatch
import interface_implements
import ../../models/vo/user_id
import ./get_articles_in_user_dto

interfaceDefs:
  type IGetArticlesInUserQuery*  = object of RootObj
    invoke:proc(self:IGetArticlesInUserQuery, userId:UserId):Future[GetArticlesInUserDto]
