import std/options
# framework
import basolato/controller
import ../../errors
import ../../usecases/get_user_show/get_user_show_usecase
import ../views/pages/user/user_show_view_model
import ../views/pages/user/user_show_view

import ../../usecases/get_articles_in_user/get_articles_in_user_usecase
import ../views/pages/user/htmx_user_feed_view
import ../views/pages/user/htmx_user_feed_view_model

import ../../usecases/get_favorites_in_user/get_favorites_in_user_usecase




proc show*(context:Context, params:Params):Future[Response] {.async.} =
  let isLogin = context.isLogin().await
  let userId = params.getStr("userId")
  let loginUserId = context.get("userId").await
  let loginUserIdOpt = if loginUserId.len > 0: loginUserId.some() else: none(string)
  let isSelf = isLogin and loginUserId == userId
  let loadFavorites = false
  try:
    let usecase = GetUserShowUsecase.init()
    let dto = usecase.invoke(userId, loginUserIdOpt).await
    let viewModel = UserShowViewModel.init(dto, isSelf, loadFavorites)
    let view = htmxUserShowView(viewModel)
    return render(view)
  except IdNotFoundError:
    return render(Http404, "")


proc articles*(context:Context, params:Params):Future[Response] {.async.} =
  let userId = params.getStr("userId")
  let loginUserId = context.get("loginUserId").await
  try:
    let usecase = GetArticlesInUserUsecase.init()
    let dto = usecase.invoke(userId).await
    let viewModel = HtmxUserFeedViewModel.init(dto, loginUserId)
    let view = htmxUserFeedView(viewModel)
    return render(view)
  except IdNotFoundError:
    return render(Http404, "")


proc favorites*(context:Context, params:Params):Future[Response] {.async.} =
  let userId = params.getStr("userId")
  let loginUserId = context.get("loginUserId").await
  try:
    let usecase = GetFavoritesInUserUsecase.init()
    let dto = usecase.invoke(userId).await
    let viewModel = HtmxUserFeedViewModel.init(dto, loginUserId)
    let view = htmxUserFeedView(viewModel)
    return render(view)
  except IdNotFoundError:
    return render(Http404, "")
