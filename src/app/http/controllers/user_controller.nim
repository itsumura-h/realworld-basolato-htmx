import std/json
# framework
import basolato/controller
import ../../usecases/get_articles_in_user/get_articles_in_user_usecase


proc show*(context:Context, params:Params):Future[Response] {.async.} =
  let isLogin = context.isLogin().await
  let userId = params.getStr("userId")
  # let isUserFollowed = false
  # let navbarActive = "none"

  # $user->load(['articles', 'followers']);

  # $userFeedNavbarItems = Helpers::userFeedNavbarItems($user);

  # if ( isLogin && auth()->user()->following($user)) {
  #     $isUserFollowed = true;
  # }

  # if ($user->isSelf) {
  #     $navbarActive = 'profile';
  # }
  let usecase = GetArticlesInUserUsecase.new()
  let dto = usecase.invoke(isLogin, userId).await

  return render(%dto)
