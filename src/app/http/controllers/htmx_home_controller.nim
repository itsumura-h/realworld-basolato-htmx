import std/asyncdispatch
import std/json
# framework
import basolato/controller
import basolato/request_validation
import basolato/view
import ../../usecases/article/get_global_feed_usecase
# import ../views/pages/home/global_feed_page_view


proc globalFeed*(context:Context, params:Params):Future[Response] {.async.} =
  let usecase = GetGlobalFeedUsecase.new()
  let res = usecase.invoke().await
  return render(%res)
  # return render(globalFeedPageView())


proc tagList*(context:Context, params:Params):Future[Response] {.async.} =
  return render("")
