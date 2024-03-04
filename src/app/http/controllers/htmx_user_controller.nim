import std/options
# framework
import basolato/controller
import ../../errors
# user shoq
import ../../usecases/get_user_show/get_user_show_usecase
import ../views/pages/user/user_show_view_model
import ../views/pages/user/user_show_view
# user feed
import ../../usecases/get_articles_in_user/get_articles_in_user_usecase
import ../views/pages/user/htmx_user_feed_view
import ../views/pages/user/htmx_user_feed_view_model
# favoriteArticles
import ../../usecases/get_favorites_in_user/get_favorites_in_user_usecase
# follow
import ../../usecases/follow_usecase
import ../../usecases/get_follow_button_in_user/get_follow_button_in_user_usecase
import ../../http/views/components/user/follow_button/follow_button_view_model
import ../../http/views/components/user/follow_button/follow_button_view
# favorite
import ../../usecases/favorite_usecase
import ../../usecases/get_favorite_button_in_user/get_favorite_button_in_user_usecase
import ../views/components/user/favorite_button/favorite_button_view_model
import ../views/components/user/favorite_button/favorite_button_view


proc show*(context:Context, params:Params):Future[Response] {.async.} =
  let isLogin = context.isLogin().await
  let userId = params.getStr("userId")
  let loginUserId = context.get("id").await
  let loginUserIdOpt = if loginUserId.len > 0: loginUserId.some() else: none(string)
  let isSelf = isLogin and loginUserId == userId
  let loadFavorites = false
  try:
    let getUserShowUsecase = GetUserShowUsecase.new()
    let userShowDto = getUserShowUsecase.invoke(userId, loginUserIdOpt).await

    let getFollowButtonUsecase = GetFollowButtonInUserUsecase.new()
    let followButtonDto = getFollowButtonUsecase.invoke(userId, loginUserId).await
    
    let viewModel = UserShowViewModel.new(userShowDto, followButtonDto, isSelf, loadFavorites)
    let view = htmxUserShowView(viewModel)
    return render(view)
  except IdNotFoundError:
    return render(Http404, "")


proc articles*(context:Context, params:Params):Future[Response] {.async.} =
  let userId = params.getStr("userId")
  let loginUserId = context.get("id").await
  try:
    let usecase = GetArticlesInUserUsecase.new()
    let dto = usecase.invoke(userId).await
    let viewModel = HtmxUserFeedViewModel.new(dto, loginUserId)
    let view = htmxUserFeedView(viewModel)
    return render(view)
  except IdNotFoundError:
    return render(Http404, "")


proc favoriteArticles*(context:Context, params:Params):Future[Response] {.async.} =
  let userId = params.getStr("userId")
  let loginUserId = context.get("id").await
  try:
    let usecase = GetFavoritesInUserUsecase.new()
    let dto = usecase.invoke(userId).await
    let viewModel = HtmxUserFeedViewModel.new(dto, loginUserId)
    let view = htmxUserFeedView(viewModel)
    return render(view)
  except IdNotFoundError:
    return render(Http404, "")


proc follow*(context:Context, params:Params):Future[Response] {.async.} =
  let userId = params.getStr("userId")
  let loginUserId = context.get("id").await
  try:
    let followUsecase = FollowUsecase.new()
    followUsecase.invoke(userId, loginUserId).await

    let getFollowButtonUsecase = GetFollowButtonInUserUsecase.new()
    let dto = getFollowButtonUsecase.invoke(userId, loginUserId).await
    let viewModel = FollowButtonViewModel.new(dto)
    let view = followButtonView(viewModel)
    return render(view)
  except:
    return render(Http400, getCurrentExceptionMsg())


proc favorite*(context:Context, params:Params):Future[Response] {.async.} =
  let articleId = params.getStr("articleId")
  let loginUserId = context.get("id").await
  try:
    let followUsecase = FavoriteUsecase.new()
    followUsecase.invoke(articleId, loginUserId).await

    let getFavoriteButtonInUserUsecase = GetFavoriteButtonInUserUsecase.new()
    let dto = getFavoriteButtonInUserUsecase.invoke(articleId, loginUserId).await
    let viewModel = FavoriteButtonViewModel.new(dto)
    let view = favoriteButtonView(viewModel)
    return render(view)
  except:
    return render(Http400, getCurrentExceptionMsg())
