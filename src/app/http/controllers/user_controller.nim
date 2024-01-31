import std/json
import std/options
# framework
import basolato/controller
import ../../errors
import ../../usecases/get_articles_in_user/get_articles_in_user_usecase
import ../views/pages/users/articles_in_user_view_model
import ../views/pages/users/articles_in_user_view


proc show*(context:Context, params:Params):Future[Response] {.async.} =
  let isLogin = context.isLogin().await
  let userId = params.getStr("userId")
  let loginUserId = context.get("userId").await
  let loginUserIdOpt = if loginUserId.len > 0: loginUserId.some() else: none(string)
  let isSelf = isLogin and loginUserId == userId
  let loadFavorites = false
  try:
    let usecase = GetArticlesInUserUsecase.new()
    let dto = usecase.invoke(userId, loginUserIdOpt).await
    let viewModel = ArticlesInUserViewModel.new(dto, isSelf, loadFavorites)
    let view = articlesInUserView(viewModel)
    return render(view)
  except IdNotFoundError:
    return render(Http404, "")
