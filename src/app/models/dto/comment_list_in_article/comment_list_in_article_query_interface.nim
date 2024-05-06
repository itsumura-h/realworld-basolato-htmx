import std/asyncdispatch
import interface_implements
import ../../vo/article_id
import ./comment_list_in_article_dto

interfaceDefs:
  type ICommentListInArticleQuery* = object of RootObj
    invoke:proc(self:ICommentListInArticleQuery, articleId:ArticleId):Future[CommentListInArticleDto]
