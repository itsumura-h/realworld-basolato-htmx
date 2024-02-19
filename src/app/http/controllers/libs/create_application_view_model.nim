import basolato/controller
import ../../views/layouts/application/application_view_model
import ../../../di_container
import ../../../usecases/get_login_user/get_login_user_query_interface
import ../../../models/aggregates/user/vo/user_id


proc createApplicationViewModel*(context:Context, title:string):Future[ApplicationViewModel] {.async.} =
  let isLogin = context.isLogin().await
  if isLogin:
    let id = context.get("id").await
    let loginUserId = UserId.new(id)
    let query = di.getLoginUserQuery
    let userDto = query.invoke(loginUserId).await
    let viewModel = ApplicationViewModel.new(title, userDto)
    return viewModel
  else:
    let viewModel = ApplicationViewModel.new(title)
    return viewModel
