import std/options
# framework
import basolato/controller
import ../../errors
# user shoq
import ../../presenters/useer_show/user_show_presenter
import ../views/pages/user/user_show_view
# # user feed
# import ../../usecases/get_articles_in_user/get_articles_in_user_usecase
# import ../views/pages/user/htmx_user_feed_view
# import ../views/pages/user/htmx_user_feed_view_model
# # favoriteArticles
# import ../../usecases/get_favorites_in_user/get_favorites_in_user_usecase
# # follow
# import ../../usecases/follow_usecase
# import ../../usecases/get_follow_button_in_user/get_follow_button_in_user_usecase
# import ../../http/views/components/user/follow_button/follow_button_view_model
# import ../../http/views/components/user/follow_button/follow_button_view
# # favorite
# import ../../usecases/favorite_usecase
# # import ../../usecases/get_favorite_button/get_favorite_button_usecase
# import ../../presenters/user_favorite_button/user_favorite_button_presenter
# import ../views/components/user/favorite_button/favorite_button_view_model
# import ../views/components/user/favorite_button/favorite_button_view


proc show*(context:Context, params:Params):Future[Response] {.async.} =
  let isLogin = context.isLogin().await
  let userId = params.getStr("userId")
  let loginUserId = context.get("id").await
  let loginUserIdOpt = if loginUserId.len > 0: loginUserId.some() else: none(string)
  try:
    let userShowPresenter = UserShowPresenter.new()
    let userShowViewModel = userShowPresenter.invoke(userId, loginUserIdOpt).await
    let view = htmxUserShowView(userShowViewModel)
    return render(view)
  except IdNotFoundError:
    return render(Http404, "")


# proc articles*(context:Context, params:Params):Future[Response] {.async.} =
#   let userId = params.getStr("userId")
#   let loginUserId = context.get("id").await
#   try:
#     let usecase = GetArticlesInUserUsecase.new()
#     let dto = usecase.invoke(userId, loginUserId).await
#     let viewModel = HtmxUserFeedViewModel.new(dto)
#     let view = htmxUserFeedView(viewModel)
#     return render(view)
#   except IdNotFoundError:
#     return render(Http404, "")


# proc favoriteArticles*(context:Context, params:Params):Future[Response] {.async.} =
#   let userId = params.getStr("userId")
#   let loginUserId = context.get("id").await
#   try:
#     let usecase = GetFavoritesInUserUsecase.new()
#     let dto = usecase.invoke(userId, loginUserId).await
#     let viewModel = HtmxUserFeedViewModel.new(dto)
#     let view = htmxUserFeedView(viewModel)
#     return render(view)
#   except IdNotFoundError:
#     return render(Http404, "")


# proc follow*(context:Context, params:Params):Future[Response] {.async.} =
#   let userId = params.getStr("userId")
#   let loginUserId = context.get("id").await
#   try:
#     let followUsecase = FollowUsecase.new()
#     followUsecase.invoke(userId, loginUserId).await

#     let getFollowButtonUsecase = GetFollowButtonInUserUsecase.new()
#     let dto = getFollowButtonUsecase.invoke(userId, loginUserId).await
#     let viewModel = FollowButtonViewModel.new(dto)
#     let view = followButtonView(viewModel)
#     return render(view)
#   except:
#     return render(Http400, getCurrentExceptionMsg())


# proc favorite*(context:Context, params:Params):Future[Response] {.async.} =
#   let articleId = params.getStr("articleId")
#   let isLogin = context.isLogin().await
#   let loginUserId = context.get("id").await
#   try:
#     let followUsecase = FavoriteUsecase.new()
#     followUsecase.invoke(articleId, loginUserId).await

#     let presenter = UserFavoriteButtonPresenter.new()
#     let viewModel = presenter.invoke(articleId, isLogin, loginUserId).await
#     let view = favoriteButtonView(viewModel)
#     return render(view)
#   except:
#     return render(Http400, getCurrentExceptionMsg())
