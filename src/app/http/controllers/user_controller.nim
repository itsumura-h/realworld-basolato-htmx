import std/options
import std/strformat
# framework
import basolato/controller
import ../../errors
import ../../usecases/get_user_show/get_user_show_usecase
import ../views/pages/user/user_show_view_model
import ../views/pages/user/user_show_view
import ./libs/create_application_view_model


proc show*(context:Context, params:Params):Future[Response] {.async.} =
  let isLogin = context.isLogin().await
  let userId = params.getStr("userId")
  let loginUserId = context.get("userId").await
  let loginUserIdOpt = if loginUserId.len > 0: loginUserId.some() else: none(string)
  let isSelf = isLogin and loginUserId == userId
  let loadFavorites = false
  try:
    let usecase = GetUserShowUsecase.new()
    let dto = usecase.invoke(userId, loginUserIdOpt).await
    let title = &"{dto.id} ― Cnduit"
    let appViewModel = createApplicationViewModel(context, title).await
    let viewModel = UserShowViewModel.new(dto, isSelf, loadFavorites)
    let view = userShowView(appViewModel, viewModel)
    return render(view)
  except IdNotFoundError:
    return render(Http404, "")


proc favorites*(context:Context, params:Params):Future[Response] {.async.} =
  let isLogin = context.isLogin().await
  let userId = params.getStr("userId")
  let loginUserId = context.get("userId").await
  let loginUserIdOpt = if loginUserId.len > 0: loginUserId.some() else: none(string)
  let isSelf = isLogin and loginUserId == userId
  let loadFavorites = true
  try:
    let usecase = GetUserShowUsecase.new()
    let dto = usecase.invoke(userId, loginUserIdOpt).await
    let title = &"Articles favorited by {dto.id} ― Cnduit"
    let appViewModel = createApplicationViewModel(context, title).await
    let viewModel = UserShowViewModel.new(dto, isSelf, loadFavorites)
    let view = userShowView(appViewModel, viewModel)
    return render(view)
  except IdNotFoundError:
    return render(Http404, "")
