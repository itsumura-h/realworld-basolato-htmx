import std/asyncdispatch
# framework
import basolato/controller
import basolato/view
import ../../data_stores/queries/get_global_feed_query
import ../../data_stores/queries/get_popular_tags_query
import ../views/pages/home/home_page_view
import ../views/pages/home/htmx_global_feed_view
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
  let query = GetGlobalFeedQuery.new()
  let res = query.invoke(page).await
  let view = htmxGlobalFeedPageView(res)
  return render(view)


proc tagList*(context:Context, params:Params):Future[Response] {.async.} =
  let query = GetPopularTagsQuery.new()
  let tags = query.invoke(5).await
  let view = htmxTagListView(tags)
  return render(view)
