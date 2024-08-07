
import std/asyncdispatch
import interface_implements


interfaceDefs:
  type ITagFeedArticleCountQuery* = object of RootObj
    invoke*: proc(
        self:ITagFeedArticleCountQuery,
        tagId:string,
      ): Future[int]
