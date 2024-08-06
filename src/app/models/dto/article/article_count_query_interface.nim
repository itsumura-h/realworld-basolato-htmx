
import std/asyncdispatch
import interface_implements
import ./article_dto


interfaceDefs:
  type IGlobalFeedArticleCountQuery* = object of RootObj
    invoke*: proc(
        self:IGlobalFeedArticleCountQuery,
      ):Future[int]
