import std/asyncdispatch
import interface_implements
import ./vo/article_id

interfaceDefs:
  type IArticleRepository*  = object of RootObj
    isExistsArticle:proc(self:IArticleRepository, articleId:ArticleId):Future[bool]
