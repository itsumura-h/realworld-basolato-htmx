import basolato/controller
import ../../views/layouts/app/app_view_model
import ../../../di_container
import ../../../usecases/get_login_user/get_login_user_query_interface
import ../../../models/vo/user_id


proc createAppViewModel*(context:Context, title:string):Future[AppViewModel] {.async.} =
  let isLogin = context.isLogin().await
  if isLogin:
    let id = context.get("id").await
    let loginUserId = UserId.new(id)
    let query = di.getLoginUserQuery
    let userDto = query.invoke(loginUserId).await
    let viewModel = AppViewModel.new(title, userDto)
    return viewModel
  else:
    let viewModel = AppViewModel.new(title)
    return viewModel
