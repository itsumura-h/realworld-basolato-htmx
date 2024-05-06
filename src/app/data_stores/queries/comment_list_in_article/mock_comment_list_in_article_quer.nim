import std/asyncdispatch
import ../../../models/dto/comment_list_in_article/comment_list_in_article_query_interface
import ../../../models/dto/comment_list_in_article/comment_list_in_article_dto
import ../../../models/vo/article_id


type MockCommentListInArticleQuery* = object of ICommentListInArticleQuery

proc new*(_:type MockCommentListInArticleQuery):MockCommentListInArticleQuery =
  return MockCommentListInArticleQuery()


method invoke*(self:MockCommentListInArticleQuery, articleId:ArticleId):Future[CommentListInArticleDto] {.async.} =
  discard
