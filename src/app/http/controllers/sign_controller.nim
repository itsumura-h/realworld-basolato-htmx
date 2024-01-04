import std/json
# framework
import basolato/controller
import basolato/view
import ../views/pages/sign/signup_page_view
import ../views/pages/sign/signin_page_view


proc signUpPage*(context:Context, params:Params):Future[Response] {.async.} =
  let oldName = old(params, "username")
  let oldEmail = old(params, "email")
  let oldParams = %*{"name": oldName, "email":oldEmail}
  return render(signUpPageView(oldParams))


proc signInPage*(context:Context, params:Params):Future[Response] {.async.} =
  return render(signInPageView())
