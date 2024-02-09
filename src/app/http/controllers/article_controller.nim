import std/asyncdispatch
# framework
import basolato/controller
import basolato/view
import ../../di_container
import ../../errors
import ../../usecases/get_article/get_article_usecase
import ../views/pages/article/article_show_view_model
import ../views/pages/article/article_show_view


proc show*(context:Context, params:Params):Future[Response] {.async.} =
  let articleId = params.getStr("articleId")
  let loginUserId = context.get("loginUserId").await
  let query = di.getArticleQuery
  let repository = di.articleRepository
  let usecase = GetArticleUsecase.new(query, repository)
  try:
    let dto = usecase.invoke(articleId).await
    let viewModel = ArticleShowViewModel.new(dto, loginUserId)
    let view = articleShowPageView(viewModel)
    return render(view)
  except IdNotFoundError:
    return render(Http404, "")
  except:
    return render(Http400, getCurrentExceptionMsg())
