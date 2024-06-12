import std/asyncdispatch
import std/options
import std/tables
# framework
import basolato/controller
import basolato/view
import basolato/request_validation
import ../../presenters/app/app_presenter
# register
import ../../presenters/form_error_message_list/form_error_message_list_presenter
import ../../usecases/create_user_usecase
import ../views/pages/register/register_view
import ../views/islands/register/register_view
import ../views/islands/form_error_message_list/form_error_message_list_view
# login
import ../../usecases/login_usecase
import ../views/islands/login/login_view
import ../views/pages/login/login_view



proc registerPage*(context:Context, params:Params):Future[Response] {.async.} =
  let appPresenter = AppPresenter.new()
  let appViewModel = appPresenter.invoke(none(string), "Sign Up ― Conduit").await
  let view = registerView(appViewModel)
  return render(view)


proc islandRegisterPage*(context:Context, params:Params):Future[Response] {.async.} =
  let view = islandRegisterView()
  return render(view)


proc register*(context:Context, params:Params):Future[Response] {.async.} =
  let name = params.getStr("name")
  let email = params.getStr("email")
  let password = params.getStr("password")

  let validation = RequestValidation.new(params)
  validation.required("name", "Username")
  validation.required("email", "Email")
  validation.email("email", "Email")
  validation.required("password", "Password")
  validation.password("password", "Password")

  if validation.hasErrors():
    var errors:seq[string]
    if validation.errors.hasKey("name"):
      errors.add(validation.errors["name"])
    if validation.errors.hasKey("email"):
      errors.add(validation.errors["email"])
    if validation.errors.hasKey("password"):
      errors.add(validation.errors["password"])

    let formErrorMessageListPresenter = FormErrorMessageListPresenter.new()
    let formErrorMessageListViewModel = formErrorMessageListPresenter.invoke(errors)
    let formErrorMessageListView = formErrorMessageListView(formErrorMessageListViewModel)
    let header = {
      "Hx-Retarget": "#form-error-message-list"
    }.newHttpHeaders()
    return render(formErrorMessageListView, header)

  try:
    let usecase = CreateUserUsecase.new()
    let id = usecase.invoke(name, email, password).await
    context.login().await
    context.set("id", id).await
    context.set("name", name).await

    let header = {
      "HX-Redirect": "/"
    }.newHttpHeaders()
    return render("", header)
  except:
    let errors = @[getCurrentExceptionMsg()]
    let formErrorMessageListPresenter = FormErrorMessageListPresenter.new()
    let formErrorMessageListViewModel = formErrorMessageListPresenter.invoke(errors)
    let formErrorMessageListView = formErrorMessageListView(formErrorMessageListViewModel)
    let header = {
      "Hx-Retarget": "#form-error-message-list"
    }.newHttpHeaders()
    return render(formErrorMessageListView, header)


proc loginPage*(context:Context, params:Params):Future[Response] {.async.} =
  let appPresenter = AppPresenter.new()
  let appViewModel = appPresenter.invoke(none(string), "Sign In ― Conduit").await
  let view = loginView(appViewModel)
  return render(view)


proc islandLoginPage*(context:Context, params:Params):Future[Response] {.async.} =
  let view = islandLoginView()
  return render(view)


proc login*(context:Context, params:Params):Future[Response] {.async.} =
  let name = params.getStr("email")
  let password = params.getStr("password")

  let validation = RequestValidation.new(params)
  validation.required("email", "Email")
  validation.required("password", "Password")

  if validation.hasErrors():
    var errors:seq[string]
    if validation.errors.hasKey("email"):
      errors.add(validation.errors["email"])
    if validation.errors.hasKey("password"):
      errors.add(validation.errors["password"])

    let formErrorMessageListPresenter = FormErrorMessageListPresenter.new()
    let formErrorMessageListViewModel = formErrorMessageListPresenter.invoke(errors)
    let formErrorMessageListView = formErrorMessageListView(formErrorMessageListViewModel)
    let header = {
      "Hx-Retarget": "#form-error-message-list"
    }.newHttpHeaders()
    return render(formErrorMessageListView, header)

  try:
    let usecase = LoginUsecase.new()
    let (id, name) = usecase.invoke(name, password).await
    context.login().await
    context.set("id", id).await
    context.set("name", name).await

    let header = {
      "HX-Redirect": "/"
    }.newHttpHeaders()
    return render("", header)
  except:
    let errors = @[getCurrentExceptionMsg()]
    let formErrorMessageListPresenter = FormErrorMessageListPresenter.new()
    let formErrorMessageListViewModel = formErrorMessageListPresenter.invoke(errors)
    let formErrorMessageListView = formErrorMessageListView(formErrorMessageListViewModel)
    let header = {
      "Hx-Retarget": "#form-error-message-list"
    }.newHttpHeaders()
    return render(formErrorMessageListView, header)



proc logout*(context:Context, params:Params):Future[Response] {.async.} =
  context.logout().await
  context.delete("id").await
  context.delete("name").await
  let header = {
    "HX-Redirect": "/"
  }.newHttpHeaders()
  return render("", header)
