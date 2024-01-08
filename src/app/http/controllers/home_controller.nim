import std/json
# framework
import basolato/controller
import basolato/request_validation
import basolato/view
# view
import ../views/pages/home/home_page_view


proc index*(context:Context, params:Params):Future[Response] {.async.} =
  return render(homePageView())
