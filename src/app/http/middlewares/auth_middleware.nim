import std/asyncdispatch
import basolato/middleware


proc checkCsrfToken*(c:Context, p:Params):Future[Response] {.async.} =
  echo "=== checkCsrfToken"
  let res = await checkCsrfToken(c.request, p)
  if res.hasError:
    raise newException(Error403, res.message)
  return next()


proc checkSessionIdMiddleware*(c:Context, p:Params):Future[Response] {.async.} =
  let res = await checkSessionId(c.request)
  if res.hasError:
    raise newException(ErrorRedirect, "/sign-in")
  return next()
