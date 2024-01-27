import std/asyncdispatch
# framework
import basolato/controller
import basolato/view
import ../../usecases/get_global_feed/get_global_feed_usecase
import ../../usecases/get_popular_tags/get_popular_tags_usecase
import ../views/pages/home/home_page_view
import ../views/pages/home/htmx_global_feed_view_model
import ../views/pages/home/htmx_global_feed_view
import ../views/pages/home/htmx_tag_item_list_view_model
import ../views/pages/home/htmx_tag_item_list_view


proc index*(context:Context, params:Params):Future[Response] {.async.} =
  let view = htmxHomeView()
  return render(view)


proc globalFeed*(context:Context, params:Params):Future[Response] {.async.} =
  let page =
    if params.hasKey("page"):
      params.getInt("page")
    else:
      1
  # let query = GetGlobalFeedQuery.new()
  # let res = query.invoke(page).await
  let usecase = GetGlobalFeedUsecase.new()
  let globalFeedDto = usecase.invoke(page).await
  let viewModel = HtmxGlobalFeedViewModel.new(globalFeedDto)
  let view = htmxGlobalFeedPageView(viewModel)
  return render(view)
  # return render(Http200, "")


proc tagList*(context:Context, params:Params):Future[Response] {.async.} =
  let usecase = GetPopularTagsUsecase.new()
  let tagsDto = usecase.invoke().await
  let viewModel = HtmxTagItemListViewModel.new(tagsDto)
  let view = htmxTagListView(viewModel)
  return render(view)
  # return render(%tagsDto)
