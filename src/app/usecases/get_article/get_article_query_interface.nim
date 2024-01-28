import std/asyncdispatch
import interface_implements
import ../../models/aggregates/article/vo/article_id
import ./get_article_dto

interfaceDefs:
  type IGetArticleQuery* = object of RootObj
    invoke:proc(self:IGetArticleQuery, articleId:ArticleId):Future[GetArticleDto]
