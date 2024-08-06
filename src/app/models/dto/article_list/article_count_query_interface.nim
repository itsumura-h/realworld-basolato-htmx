
import std/asyncdispatch
import interface_implements


interfaceDefs:
  type IGlobalFeedArticleCountQuery* = object of RootObj
    invoke*: proc(
        self:IGlobalFeedArticleCountQuery,
      ):Future[int]
