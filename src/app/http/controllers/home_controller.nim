# framework
import basolato/controller
import basolato/view
import ../../presenters/app/app_presenter
import ../../presenters/home/global_feed_presenter
import ../../presenters/home/tag_feed_presenter
import ../views/pages/home/home_view


proc index*(context:Context, params:Params):Future[Response] {.async.} =
  let isLogin = context.isLogin().await
  let userId = context.get("id").await

  let appPresenter = AppPresenter.new()
  let appViewModel = appPresenter.invoke(isLogin, userId, "conduit").await

  let globalFeedPresenter = GlobalFeedPresenter.new()
  let homeViewModel = globalFeedPresenter.invoke()
  let view = homeView(appViewModel, homeViewModel)
  return render(view)


proc tagFeed*(context:Context, params:Params):Future[Response] {.async.} =
  let isLogin = context.isLogin().await
  let userId = context.get("id").await

  let appPresenter = AppPresenter.new()
  let appViewModel = appPresenter.invoke(isLogin, userId, "conduit").await
  
  let page =
    if params.hasKey("page"):
      params.getInt("page")
    else:
      1
  let hasPage = page > 1
  let tagName = params.getStr("tag")

  let tagFeedPresenter = TagFeedPresenter.new()
  let homeViewModel = tagFeedPresenter.invoke(
    tagName,
    hasPage,
    page
  )
  let view = homeView(appViewModel, homeViewModel)
  return render(view)
