import std/asyncdispatch
import std/json
import basolato/controller
import ../views/pages/profile/profile_page


proc show*(context:Context):Future[Response] {.async.} =
  let view = profilePage().await
  return render(view)


proc favoriteShow*(context:Context):Future[Response] {.async.} =
  let view = profilePage().await
  return render(view)
