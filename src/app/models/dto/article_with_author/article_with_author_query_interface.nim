import std/asyncdispatch
import std/options
import interface_implements
import ./article_with_author_dto
import ../../vo/article_id
import ../../vo/user_id

interfaceDefs:
  type IArticleWithAuthorQuery* = object of RootObj
    invoke: proc(
        self:IArticleWithAuthorQuery,
        offset:int,
        display:int
      ):Future[seq[ArticleWithAuthorDto]]
