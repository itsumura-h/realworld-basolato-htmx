# framework
import basolato/controller
import basolato/view
# view
import ../views/pages/home/home_view_model
import ../views/pages/home/home_view


proc index*(context:Context, params:Params):Future[Response] {.async.} =
  let viewModel = HomeViewModel.new()
  let view = homeView(viewModel)
  return render(view)


proc tagFeed*(context:Context, params:Params):Future[Response] {.async.} =
  let page =
    if params.hasKey("page"):
      params.getInt("page")
    else:
      1
  let hasPage = page > 1
  let feedType = "tag"
  let tagName = params.getStr("tag")
  let viewModel = HomeViewModel.new(
    feedType,
    tagName,
    hasPage,
    page
  )
  let view = homeView(viewModel)
  return render(view)
