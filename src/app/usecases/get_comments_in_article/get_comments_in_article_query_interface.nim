import std/asyncdispatch
import interface_implements
import ./get_comments_in_article_dto


interfaceDefs:
  type IGetCommentsInArticleQuery* = object of RootObj
    invoke: proc(self:IGetCommentsInArticleQuery, articleId:string):Future[GetCommentsInArticleDto]
