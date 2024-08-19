
import std/asyncdispatch
import interface_implements
import ./article_detail_dto


interfaceDefs:
  type IArticleDetailQuery* = object of RootObj
    getArticleById*: proc(self: IArticleDetailQuery, articleId: string): Future[ArticleDetailDto]
