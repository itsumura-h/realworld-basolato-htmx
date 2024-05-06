import std/asyncdispatch
# framework
import basolato/controller
import basolato/view
import ../../di_container
import ../../errors
import ../../presenters/app_presenter
import ../../presenters/article_presenter
import ../views/pages/article/article_view_model
import ../views/pages/article/article_view


proc show*(context:Context, params:Params):Future[Response] {.async.} =
  let isLogin = context.isLogin().await
  let userId = context.get("id").await
  let articleId = params.getStr("articleId")

  try:
    let articleShowPresenter = ArticleShowPresenter.new()
    let articleShowViewModel = articleShowPresenter.invoke(articleId, userId).await
    let appPresenter = AppPresenter.new()
    let appViewModel = appPresenter.invoke(isLogin, userId, articleShowViewModel.article.title).await
    let view = articleShowPageView(appViewModel, articleShowViewModel)
    return render(view)
  except IdNotFoundError:
    return render(Http404, "")
  except:
    return render(Http400, getCurrentExceptionMsg())
