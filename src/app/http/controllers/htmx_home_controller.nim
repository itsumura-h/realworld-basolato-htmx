import std/asyncdispatch
# framework
import basolato/controller
import basolato/view
# global feed
import ../../usecases/get_global_feed/get_global_feed_usecase
import ../views/pages/home/home_view_model
import ../views/pages/home/home_view
import ../views/pages/home/htmx_post_preview_view_model
import ../views/pages/home/htmx_post_preview_view
# tag feed
import ../../usecases/get_tag_feed/get_tag_feed_usecase
# tag list
import ../../usecases/get_popular_tags/get_popular_tags_usecase
import ../views/pages/home/htmx_tag_item_list_view_model
import ../views/pages/home/htmx_tag_item_list_view


proc index*(context:Context, params:Params):Future[Response] {.async.} =
  let viewModel = HomeViewModel.new()
  let view = htmxHomeView(viewModel)
  return render(view)


proc globalFeed*(context:Context, params:Params):Future[Response] {.async.} =
  let page =
    if params.hasKey("page"):
      params.getInt("page")
    else:
      1
  let usecase = GetGlobalFeedUsecase.new()
  let dto = usecase.invoke(page).await
  let viewModel = HtmxPostPreviewViewModel.new(dto)
  let view = htmxPostPreviewView(viewModel)
  return render(view)


proc tagFeed*(context:Context, params:Params):Future[Response] {.async.} =
  let tagName = params.getStr("tagName")
  let page =
    if params.hasKey("page"):
      params.getInt("page")
    else:
      1
  let usecase = GetTagFeedUsecase.new()
  let dto = usecase.invoke(tagName, page).await
  let viewModel = HtmxPostPreviewViewModel.new(dto, tagName)
  let view = htmxPostPreviewView(viewModel)
  return render(view)


proc tagList*(context:Context, params:Params):Future[Response] {.async.} =
  let usecase = GetPopularTagsUsecase.new()
  let tagsDto = usecase.invoke().await
  let viewModel = HtmxTagItemListViewModel.new(tagsDto)
  let view = htmxTagListView(viewModel)
  return render(view)
