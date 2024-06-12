import std/asyncdispatch
import std/options
# framework
import basolato/controller
import basolato/view
import ../../presenters/app/app_presenter
import ../../presenters/feed/global_feed_presenter
# import ../../presenters/feed/tag_feed_presenter
import ../../presenters/feed/your_feed_presenter
import ../views/pages/feed/feed_view
import ../views/islands/feed/feed_view


proc index*(context:Context, params:Params):Future[Response] {.async.} =
  let page =
    if params.hasKey("page"):
      params.getInt("page")
    else:
      1

  let loginUserId =
    if context.isLogin().await:
      context.get("id").await.some()
    else:
      none(string)

  let appPresenter = AppPresenter.new()
  let appViewModel = appPresenter.invoke(loginUserId, "conduit").await

  let globalFeedPresenter = GlobalFeedPresenter.new()
  let feedViewModel = globalFeedPresenter.invoke(page, loginUserId).await
  let view = feedView(appViewModel, feedViewModel)
  return render(view)


proc islandGlobalFeed*(context:Context, params:Params):Future[Response] {.async.} =
  let page =
    if params.hasKey("page"):
      params.getInt("page")
    else:
      1

  let loginUserId =
    if context.isLogin().await:
      context.get("id").await.some()
    else:
      none(string)

  let globalFeedPresenter = GlobalFeedPresenter.new()
  let feedViewModel = globalFeedPresenter.invoke(page, loginUserId).await
  let view = islandFeedView(feedViewModel)
  return render(view)


proc yourFeed*(context:Context, params:Params):Future[Response] {.async.} =
  let page =
    if params.hasKey("page"):
      params.getInt("page")
    else:
      1

  let loginUserId = context.get("id").await

  let appPresenter = AppPresenter.new()
  let appViewModel = appPresenter.invoke(loginUserId.some(), "conduit").await

  let presenter = YourFeedPresenter.new()
  let viewModel = presenter.invoke(page, loginUserId).await
  let view = feedView(appViewModel, viewModel)
  return render(view)


proc islandYourFeed*(context:Context, params:Params):Future[Response] {.async.} =
  let page =
    if params.hasKey("page"):
      params.getInt("page")
    else:
      1

  let loginUserId = context.get("id").await

  let presenter = YourFeedPresenter.new()
  let viewModel = presenter.invoke(page, loginUserId).await
  let view = islandFeedView(viewModel)
  return render(view)


# proc tagFeed*(context:Context, params:Params):Future[Response] {.async.} =
#   let loginUserId =
#     if context.isLogin().await:
#       context.get("id").await.some()
#     else:
#       none(string)

#   let appPresenter = AppPresenter.new()
#   let appViewModel = appPresenter.invoke(loginUserId, "conduit").await
  
#   let page =
#     if params.hasKey("page"):
#       params.getInt("page")
#     else:
#       1
#   let hasPage = page > 1
#   let tagName = params.getStr("tag")

#   let tagFeedPresenter = TagFeedPresenter.new()
#   let homeViewModel = tagFeedPresenter.invoke(
#     tagName,
#     hasPage,
#     page
#   )
#   let view = homeView(appViewModel, homeViewModel)
#   return render(view)
