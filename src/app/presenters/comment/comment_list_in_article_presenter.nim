import std/asyncdispatch
import ../../models/dto/comment_list_in_article/comment_list_in_article_dto
import ../../models/dto/comment_list_in_article/comment_list_in_article_query_interface
import ../../models/vo/article_id
import ../../http/views/pages/comment/comment_view_model
import ../../di_container


type CommentListInArticlePresenter* = object
  query:ICommentListInArticleQuery

proc new*(_:type CommentListInArticlePresenter):CommentListInArticlePresenter =
  return CommentListInArticlePresenter(
    query: di.commentListInArticleQuery
  )


proc invoke*(self:CommentListInArticlePresenter, articleId:string, isLogin:bool):Future[CommentViewModel] {.async.} =
  let articleId = ArticleId.new(articleId)
  let dto = self.query.invoke(articleId).await
  let viewModel = CommentViewModel.new(dto, isLogin)
  return viewModel
