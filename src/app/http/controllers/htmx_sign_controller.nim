# framework
import basolato/controller
import basolato/request_validation
import basolato/view
import ../../usecases/create_user_usecase


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
  usecase.invoke(name, email, password).await
  context.login().await
  context.set("name", name).await
  return redirect("/")
