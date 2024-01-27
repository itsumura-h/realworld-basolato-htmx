import std/asyncdispatch
# framework
import basolato/controller
import basolato/view
import ../../di_container

import ../../usecases/get_article/get_article_usecase
import ../views/pages/article/article_show_view_model
import ../views/pages/article/article_show_view

import ../../usecases/get_comments_in_article/get_comments_in_article_usecase
import ../views/pages/comment/comment_view_model
import ../views/pages/comment/comment_wrapper_view


proc show*(context:Context, params:Params):Future[Response] {.async.} =
  let articleId = params.getStr("articleId")
  let query = di.getArticleQuery
  let usecase = GetArticleUsecase.new(query)
  let dto = usecase.invoke(articleId).await
  let viewModel = ArticleShowViewModel.new(dto)
  let view = htmxArticleShowView(viewModel)
  return render(view)


proc comments*(context:Context, params:Params):Future[Response] {.async.} =
  let articleId = params.getStr("articleId")
  let query = di.getCommentsInArticleQuery
  let usecase = GetCommentsInArticleUsecase.new(query)
  let dto = usecase.invoke(articleId).await
  let viewModel = CommentViewModel.new(dto, false)
  let view = commentWrapperView(viewModel)
  return render(view)
