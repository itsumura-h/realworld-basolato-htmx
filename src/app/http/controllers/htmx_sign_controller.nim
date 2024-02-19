# framework
import basolato/controller
import basolato/request_validation
import basolato/view
import ../../usecases/create_user_usecase
import ../views/pages/signup/signup_view_model
import ../views/pages/signup/signup_view
import ../views/pages/signin/signin_view_model
import ../views/pages/signin/signin_view
import ../../usecases/login_usecase


proc signUpPage*(context:Context, params:Params):Future[Response] {.async.} =
  let oldName = params.old("username")
  let oldEmail = params.old("email")
  let viewModel = SignUpViewModel.new(oldName, oldEmail)
  let view = htmxSignUpView(viewModel)
  return render(view)

proc signUp*(context:Context, params:Params):Future[Response] {.async.} =
  let validation = RequestValidation.new(params)
  validation.required("username")
  validation.required("email")
  validation.email("email")
  validation.required("password")

  if validation.hasErrors():
    context.storeValidationResult(validation).await
    return render(Http400, "")
  
  let name = params.getStr("username")
  let email = params.getStr("email")
  let password = params.getStr("password")

  let usecase = CreateUserUsecase.new()
  let id = usecase.invoke(name, email, password).await
  context.login().await
  context.set("id", id).await
  context.set("name", name).await

  var header = newHttpHeaders()
  header.add("HX-Redirect", "/")
  return render("", header)


proc signInPage*(context:Context, params:Params):Future[Response] {.async.} =
  let oldEmail = params.old("email")
  let viewModel = SignInViewModel.new(oldEmail)
  let view = htmxSignInView(viewModel)
  return render(view)


proc signIn*(context:Context, params:Params):Future[Response] {.async.} =
  let validation = RequestValidation.new(params)
  validation.required("email")
  validation.email("email")
  validation.required("password")

  if validation.hasErrors():
    context.storeValidationResult(validation).await
    return render(Http400, "")

  let email = params.getStr("email")
  let password = params.getStr("password")

  let usecase = LoginUsecase.new()
  let (id, name) = usecase.invoke(email, password).await 
  context.login().await
  context.set("id", id).await
  context.set("name", name).await

  var header = newHttpHeaders()
  header.add("HX-Redirect", "/")
  return render("", header)


proc logout*(context:Context, params:Params):Future[Response] {.async.} =
  context.logout().await
  context.delete("id").await
  context.delete("name").await
  var header = newHttpHeaders()
  header.add("HX-Redirect", "/")
  return render("", header)
