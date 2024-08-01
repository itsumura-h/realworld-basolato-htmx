import std/asyncdispatch
import basolato/middleware


proc loginSkip*(c:Context):Future[Response] {.async.} =
  if c.isLogin().await:
    return redirect("/")
  return next()


proc shouldLogin*(c:Context):Future[Response] {.async.} =
  if not c.isLogin().await:
    return redirect("/login")
  return next()


proc islandShouldLogin*(c:Context):Future[Response] {.async.} =
  if not c.isLogin().await:
    return redirect("/login")
  return next()
