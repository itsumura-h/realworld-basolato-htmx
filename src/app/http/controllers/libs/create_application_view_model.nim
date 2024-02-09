import basolato/controller
import ../../views/layouts/application/application_view_model

proc createApplicationViewModel*(context:Context, title:string):Future[ApplicationViewModel] {.async.} =
  let isLogin = context.isLogin().await
  let name = context.get("name").await
  let viewModel = ApplicationViewModel.new(title, isLogin, name)
  return viewModel
