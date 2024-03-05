import std/asyncdispatch
# framework
import basolato/controller
import basolato/view
import ../../di_container
import ../../errors
import ../../usecases/get_article_in_feed/get_article_in_feed_usecase
import ../views/pages/article/article_show_view_model
import ../views/pages/article/article_show_view
import ./libs/create_app_view_model


proc show*(context:Context, params:Params):Future[Response] {.async.} =
  let articleId = params.getStr("articleId")
  let loginUserId = context.get("id").await
  let query = di.getArticleInFeedQuery
  let repository = di.articleRepository
  let usecase = GetArticleInFeedUsecase.new(query, repository)
  try:
    let dto = usecase.invoke(articleId, loginUserId).await
    let appViewModel = createAppViewModel(context, dto.article.title).await
    let viewModel = ArticleShowViewModel.new(dto, loginUserId)
    let view = articleShowPageView(appViewModel, viewModel)
    return render(view)
  except IdNotFoundError:
    return render(Http404, "")
  except:
    return render(Http400, getCurrentExceptionMsg())
