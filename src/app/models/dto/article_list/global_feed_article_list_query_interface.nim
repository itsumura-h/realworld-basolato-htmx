
import std/asyncdispatch
import interface_implements
import ./article_row_dto


interfaceDefs:
  type IGlobalFeedArticleListQuery* = object of RootObj
    invoke*: proc(
        self:IGlobalFeedArticleListQuery,
        offset:int,
        display:int
      ):Future[seq[ArticleRowDto]]
