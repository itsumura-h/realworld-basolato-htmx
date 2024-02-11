import basolato/controller
import ../../usecases/get_setting/get_setting_usecase
import ../views/pages/setting/setting_view_model
import ../views/pages/setting/setting_view


proc index*(context:Context, parmas:Params):Future[Response] {.async.} =
  let userId = context.get("id").await
  let usecase = GetSettingUsecase.new()
  let dto = usecase.invoke(userId).await
  let viewModel = SettingViewModel.new(dto)
  let view = htmxSettingView(viewModel)
  return render(view)


proc update*(context:Context, parmas:Params):Future[Response] {.async.} =
  let userId = context.get("id").await
  let usecase = GetSettingUsecase.new()
  let dto = usecase.invoke(userId).await
  let viewModel = SettingViewModel.new(dto)
  let view = htmxSettingView(viewModel)
  return render(view)
