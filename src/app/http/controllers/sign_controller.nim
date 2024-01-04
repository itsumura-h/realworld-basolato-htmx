import std/json
# framework
import basolato/controller
import ../views/pages/sign/signup_page_view
import ../views/pages/sign/signin_page_view


proc signUpPage*(context:Context, params:Params):Future[Response] {.async.} =
  return render(signUpPageView())


proc signInPage*(context:Context, params:Params):Future[Response] {.async.} =
  return render(signInPageView())
