# framework
import basolato/controller
import basolato/view
import ./libs/create_application_view_model
# view
import ../views/pages/home/home_view_model
import ../views/pages/home/home_view


proc index*(context:Context, params:Params):Future[Response] {.async.} =
  let appViewModel = createApplicationViewModel(context, "conduit").await
  let viewModel = HomeViewModel.init()
  let view = homeView(appViewModel, viewModel)
  return render(view)


proc tagFeed*(context:Context, params:Params):Future[Response] {.async.} =
  let appViewModel = createApplicationViewModel(context, "conduit").await
  let page =
    if params.hasKey("page"):
      params.getInt("page")
    else:
      1
  let hasPage = page > 1
  let feedType = "tag"
  let tagName = params.getStr("tag")
  let viewModel = HomeViewModel.init(
    feedType,
    tagName,
    hasPage,
    page
  )
  let view = homeView(appViewModel, viewModel)
  return render(view)
