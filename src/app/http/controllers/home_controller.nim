# framework
import basolato/controller
import basolato/view
# view
import ../views/pages/home/home_view


proc index*(context:Context, params:Params):Future[Response] {.async.} =
  return render(homeView())
