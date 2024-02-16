import std/json
import basolato/controller
import basolato/request_validation
import ../../errors
import ../../usecases/get_login_user/get_login_user_usecase
import ../views/pages/setting/setting_view_model
import ../views/pages/setting/setting_view

import ../../usecases/update_user_usecase
import ../views/components/form_error_message/form_error_message_view_model
import ../views/components/form_error_message/form_error_message_view


proc index*(context:Context, params:Params):Future[Response] {.async.} =
  let userId = context.get("id").await
  let usecase = GetLoginUserUsecase.init()
  let dto = usecase.invoke(userId).await
  let viewModel = SettingViewModel.init(dto)
  let view = htmxSettingView(viewModel)
  return render(view)


proc update*(context:Context, params:Params):Future[Response] {.async.} =
  let v = RequestValidation.new(params)
  v.required("image_url")
  v.required("name")
  v.required("email")
  # v.required("password")
  v.email("email")
  if v.hasErrors:
    var errorMessages:seq[string]
    let errors = %v.errors
    for (key, rows) in errors.pairs:
      for row in rows.items:
        errorMessages.add(row.getStr())
    let viewModel = FormErrorMessageViewModel.init(errorMessages)
    let view = formErrorMessageView(viewModel)
    let header = {
      "HX-Reswap": "innerHTML show:top",
      "HX-Retarget": "#settings-form-message"
    }.newHttpHeaders()
    return render(view, header)

  let userId = context.get("id").await
  let image = params.getStr("image_url")
  let name = params.getStr("name")
  let bio = params.getStr("bio")
  let email = params.getStr("email")
  let password = params.getStr("password")
  
  try:
    let usecase = UpdateUserUsecase.init()
    usecase.invoke(userId, name, email, password, bio, image).await
    let viewModel = SettingViewModel.init(name, email, bio, image, "Successfully updated")
    let view = htmxSettingView(viewModel)
    return render(view)
  except IdNotFoundError:
    let viewModel = FormErrorMessageViewModel.init(@[getCurrentExceptionMsg()])
    let view = formErrorMessageView(viewModel)
    let header = {
      "HX-Reswap": "innerHTML show:top",
      "HX-Retarget": "#settings-form-message"
    }.newHttpHeaders()
    return render(view, header)
  except DomainError:
    let viewModel = FormErrorMessageViewModel.init(@[getCurrentExceptionMsg()])
    let view = formErrorMessageView(viewModel)
    let header = {
      "HX-Reswap": "innerHTML show:top",
      "HX-Retarget": "#settings-form-message"
    }.newHttpHeaders()
    return render(view, header)
  except:
    return render(Http500, getCurrentExceptionMsg())
