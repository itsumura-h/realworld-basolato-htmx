import std/asyncdispatch
import basolato/middleware


proc shouldLogin*(c:Context, p:Params):Future[Response] {.async.} =
  echo "=== shouldLogin"
  if not c.isLogin().await:
    return redirect("/sign-in")

proc htmxShouldLogin*(c:Context, p:Params):Future[Response] {.async.} =
  if not c.isLogin().await:
    var header = newHttpHeaders()
    header.add("HX-Redirect", "/sign-in")
    return render(Http303, "", header)
