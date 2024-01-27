import std/asyncdispatch
# framework
import basolato/controller
import basolato/view
import ../../di_container
import ../../usecases/get_article/get_article_usecase
import ../views/pages/article/article_show_view_model
import ../views/pages/article/article_show_view


proc show*(context:Context, params:Params):Future[Response] {.async.} =
  let articleId = params.getStr("articleId")
  let query = di.getArticleQuery
  let usecase = GetArticleUsecase.new(query)
  let dto = usecase.invoke(articleId).await
  let viewModel = ArticleShowViewModel.new(dto)
  let view = articleShowPageView(viewModel)
  return render(view)
