import basolato/controller
import ../../usecases/get_login_user/get_login_user_usecase
import ../views/pages/setting/setting_view_model
import ../views/pages/setting/setting_view
import ./libs/create_application_view_model


proc index*(context:Context, parmas:Params):Future[Response] {.async.} =
  let userId = context.get("id").await
  let usecase = GetLoginUserUsecase.new()
  let dto = usecase.invoke(userId).await
  let viewModel = SettingViewModel.new(dto)
  let appViewModel = createApplicationViewModel(context, "Setting ― Conduit").await
  let view = settingView(appViewModel, viewModel)
  return render(view)
