import std/asyncdispatch
import std/strformat
# framework
import basolato/controller
import basolato/view
import ../../di_container
# article show
import ../../usecases/get_article_in_feed/get_article_in_feed_usecase
import ../views/pages/article/article_show_view_model
import ../views/pages/article/article_show_view
# comment
import ../../usecases/get_comments_in_article/get_comments_in_article_usecase
import ../views/pages/comment/comment_view_model
import ../views/pages/comment/comment_wrapper_view
# delete
import ../../usecases/delete_article_usecase
# favorite
import ../../usecases/favorite_usecase
import ../../usecases/get_favorite_button/get_favorite_button_usecase
import ../views/components/article/favorite_button/favorite_button_view_model
import ../views/components/article/favorite_button/favorite_button_view


proc show*(context:Context, params:Params):Future[Response] {.async.} =
  let articleId = params.getStr("articleId")
  let loginUserId = context.get("id").await
  let query = di.getArticleInFeedQuery
  let repository = di.articleRepository
  let usecase = GetArticleInFeedUsecase.new(query, repository)
  let dto = usecase.invoke(articleId, loginUserId).await
  let viewModel = ArticleShowViewModel.new(dto, loginUserId)
  let view = htmxArticleShowView(viewModel)
  return render(view)


proc comments*(context:Context, params:Params):Future[Response] {.async.} =
  let articleId = params.getStr("articleId")
  let isLogin = false
  let query = di.getCommentsInArticleQuery
  let usecase = GetCommentsInArticleUsecase.new(query)
  let dto = usecase.invoke(articleId).await
  let viewModel = CommentViewModel.new(dto, isLogin)
  let view = commentWrapperView(viewModel)
  return render(view)


proc delete*(context:Context, params:Params):Future[Response] {.async.} =
  let articleId = params.getStr("articleId")
  let userId = context.get("id").await
  let usecase = DeleteArticleUsecase.new()
  usecase.invoke(articleId).await
  let header = {
    "HX-Redirect": &"/users/{userId}",
  }.newHttpHeaders()
  return render("", header)


proc favorite*(context:Context, params:Params):Future[Response] {.async.} =
  let articleId = params.getStr("articleId")
  let loginUserId = context.get("id").await
  try:
    let followUsecase = FavoriteUsecase.new()
    followUsecase.invoke(articleId, loginUserId).await

    let getFavoriteButtonUsecase = GetFavoriteButtonUsecase.new()
    let dto = getFavoriteButtonUsecase.invoke(articleId, loginUserId).await
    let viewModel = FavoriteButtonViewModel.new(dto)
    let view = favoriteButtonView(viewModel)
    return render(view)
  except:
    return render(Http400, getCurrentExceptionMsg())
