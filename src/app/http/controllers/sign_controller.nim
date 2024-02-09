import std/json
# framework
import basolato/controller
import basolato/view
import ../views/pages/signup/signup_view_model
import ../views/pages/signup/signup_view
import ../views/pages/signin/signin_view_model
import ../views/pages/signin/signin_view


proc signUpPage*(context:Context, params:Params):Future[Response] {.async.} =
  let oldName = old(params, "username")
  let oldEmail = old(params, "email")
  let viewModel = SignUpViewModel.new(oldName, oldEmail)
  let view = signUpView(viewModel)
  return render(view)


proc signInPage*(context:Context, params:Params):Future[Response] {.async.} =
  let oldEmail = old(params, "email")
  let viewModel = SignInViewModel.new(oldEmail)
  let view = signInView(viewModel)
  return render(view)
