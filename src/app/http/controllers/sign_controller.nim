# framework
import basolato/controller
import basolato/view
import ../views/pages/signup/signup_view_model
import ../views/pages/signup/signup_view
import ../views/pages/signin/signin_view_model
import ../views/pages/signin/signin_view
import ./libs/create_application_view_model


proc signUpPage*(context:Context, params:Params):Future[Response] {.async.} =
  let appViewModel = createApplicationViewModel(context, "Sign Up ― Conduit").await
  let oldName = params.old("username")
  let oldEmail = params.old("email")
  let viewModel = SignUpViewModel.new(oldName, oldEmail)
  let view = signUpView(appViewModel, viewModel)
  return render(view)


proc signInPage*(context:Context, params:Params):Future[Response] {.async.} =
  let appViewModel = createApplicationViewModel(context, "Sign In ― Conduit").await
  let oldEmail = params.old("email")
  let viewModel = SignInViewModel.new(oldEmail)
  let view = signInView(appViewModel, viewModel)
  return render(view)


proc logout*(context:Context, params:Params):Future[Response] {.async.} =
  context.logout().await
  context.delete("id").await
  context.delete("name").await
  return redirect("/")
