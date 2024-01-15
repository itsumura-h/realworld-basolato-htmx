import std/asyncdispatch
import std/json
# framework
import basolato/controller
import basolato/request_validation
import basolato/view
import ../../data_stores/queries/get_global_feed_query
import ../../data_stores/queries/get_favorite_tags_query
import ../views/pages/home/htmx_global_feed_view
import ../views/pages/home/htmx_tag_item_list_view


proc globalFeed*(context:Context, params:Params):Future[Response] {.async.} =
  let page =
    if params.hasKey("page"):
      params.getInt("page")
    else:
      1
  let query = GetGlobalFeedQuery.new()
  let res = query.invoke(page).await
  let view = globalFeedPageView(res)
  return render(view)


proc tagList*(context:Context, params:Params):Future[Response] {.async.} =
  let query = GetFavoriteTagsQuery.new()
  let tags = query.invoke(5).await
  let view = htmlTagListView(tags)
  return render(view)
