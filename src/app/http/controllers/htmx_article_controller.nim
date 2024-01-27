import std/asyncdispatch
# framework
import basolato/controller
import basolato/view
import ../../di_container
import ../views/pages/article/htmx_article_show_view
import ../../data_stores/queries/get_article_query

import ../../usecases/get_comments_in_article/get_comments_in_article_usecase
import ../../data_stores/queries/get_comments_in_article/mock_get_comments_in_article_query
import ../../data_stores/queries/get_comments_in_article/get_comments_in_article_query
import ../views/pages/comment/comment_view_model
import ../views/pages/comment/comment_wrapper_view


proc show*(context:Context, params:Params):Future[Response] {.async.} =
  let articleId = params.getStr("articleId")
  let query = GetArticleQuery.new()
  let vieeModel = query.invoke(articleId).await
  let view = htmxArticleShowView(vieeModel)
  return render(view)


proc comments*(context:Context, params:Params):Future[Response] {.async.} =
  let articleId = params.getStr("articleId")
  let query = di.getCommentsInArticleQuery
  let usecase = GetCommentsInArticleUsecase.new(query)
  let dto = usecase.invoke(articleId).await
  let viewModel = CommentViewModel.new(dto, false)
  let view = commentWrapperView(viewModel)
  return render(view)
