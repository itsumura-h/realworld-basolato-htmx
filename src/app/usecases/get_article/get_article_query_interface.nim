import std/asyncdispatch
import interface_implements
import ./get_article_dto

interfaceDefs:
  type IGetArticleQuery* = object of RootObj
    invoke:proc(self:IGetArticleQuery, articleId:string):Future[GetArticleDto]
