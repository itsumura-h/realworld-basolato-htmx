import basolato/controller
import ../../presenters/app_presenter
import ../../presenters/setting_presenter
import ../views/pages/setting/setting_view_model
import ../views/pages/setting/setting_view
import ../../presenter/app_presenter


proc index*(context:Context, parmas:Params):Future[Response] {.async.} =
  let isLogin = context.isLogin().await
  let userId = context.get("id").await
  let appPresenter = AppPresenter.new()
  let appViewModel = appPresenter.invoke(isLogin, userId, "Setting ― Conduit").await
  let settingPresenter = SettingPresenter.new()
  let settingViewModel = settingPresenter.invoke(userId).await
  let view = settingView(appViewModel, settingViewModel)
  return render(view)
