
import std/asyncdispatch
import interface_implements
import ./article_list_dto


interfaceDefs:
  type ITagFeedArticleListQuery* = object of RootObj
    invoke*: proc(
        self:ITagFeedArticleListQuery,
        tagId:string,
        offset:int,
        display:int,
      ):Future[seq[ArticleDto]]
