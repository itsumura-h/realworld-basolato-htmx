import std/asyncdispatch
import std/options
import basolato/controller
import ../../presenters/app/app_presenter
# feed
import ../views/islands/feed/feed_view_model
import ../views/islands/feed/feed_view
import ../views/pages/feed/feed_view
# register
import ../views/islands/register/register_view
import ../views/pages/register/register_view
#login
import ../views/islands/login/login_view
import ../views/pages/login/login_view
# profile
import ../views/islands/profile/profile_view_model
import ../views/islands/profile/profile_view
import ../views/pages/profile/profile_view
# setting
import ../views/islands/setting/setting_view
import ../views/pages/setting/setting_view
# feed navbar
import ../views/components/feed_navbar/feed_navbar_view_model
# article
import ../views/pages/article/article_view
import ../views/islands/article/article_view


# proc globalFeed*(context:Context, params:Params):Future[Response] {.async.} =
#   # let loginUserId = none(string)
#   let loginUserId = "medy".some()
#   let appPresenter = AppPresenter.new()
#   let appViewModel = appPresenter.invoke(loginUserId, "Home").await
#   let feedNavbarViewModel = FeedNavbarViewModel.globalFeed(loginUserId)
#   let homeViewModel = FeedViewModel.new(feedNavbarViewModel)
#   let feedView = feedView(appViewModel, homeViewModel)
#   return render(feedView)


# proc islandGlobalFeed*(context:Context, params:Params):Future[Response] {.async.} =
#   # let loginUserId = none(string)
#   let loginUserId = "medy".some()
#   let feedNavbarViewModel = FeedNavbarViewModel.globalFeed(loginUserId)
#   let homeViewModel = FeedViewModel.new(feedNavbarViewModel)
#   let feedView = islandHomeView(homeViewModel)
#   return render(feedView)


# proc yourFeed*(context:Context, params:Params):Future[Response] {.async.} =
#   # let loginUserId = none(string)
#   let loginUserId = "medy".some()
#   let appPresenter = AppPresenter.new()
#   let appViewModel = appPresenter.invoke(loginUserId, "Home").await
#   let feedNavbarViewModel = FeedNavbarViewModel.yourFeed(loginUserId.get())
#   let homeViewModel = FeedViewModel.new(feedNavbarViewModel)
#   let feedView = feedView(appViewModel, homeViewModel)
#   return render(feedView)


# proc islandYourFeed*(context:Context, params:Params):Future[Response] {.async.} =
#   # let loginUserId = none(string)
#   let loginUserId = "medy".some()
#   let feedNavbarViewModel = FeedNavbarViewModel.yourFeed(loginUserId.get())
#   let homeViewModel = FeedViewModel.new(feedNavbarViewModel)
#   let feedView = islandHomeView(homeViewModel)
#   return render(feedView)


# proc tagFeed*(context:Context, params:Params):Future[Response] {.async.} =
#   # let loginUserId = none(string)
#   let loginUserId = "medy".some()
#   let appPresenter = AppPresenter.new()
#   let appViewModel = appPresenter.invoke(loginUserId, "Home").await
#   let feedNavbarViewModel = FeedNavbarViewModel.tagFeed(loginUserId, "javascript", "JavaScript")
#   let homeViewModel = FeedViewModel.new(feedNavbarViewModel)
#   let feedView = feedView(appViewModel, homeViewModel)
#   return render(feedView)


# proc register*(context:Context, params:Params):Future[Response] {.async.} =
#   let appPresenter = AppPresenter.new()
#   let appViewModel = appPresenter.invoke(none(string), "Register").await
#   let registerView = registerView(appViewModel)
#   return render(registerView)


# proc islandRegister*(context:Context, params:Params):Future[Response] {.async.} =
#   let registerView = islandRegisterView()
#   return render(registerView)


# proc login*(context:Context, params:Params):Future[Response] {.async.} =
#   let appPresenter = AppPresenter.new()
#   let appViewModel = appPresenter.invoke(none(string), "Login").await
#   let loginView = loginView(appViewModel)
#   return render(loginView)


# proc islandLogin*(context:Context, params:Params):Future[Response] {.async.} =
#   let loginView = islandLoginView()
#   return render(loginView)


proc profile*(context:Context, params:Params):Future[Response] {.async.} =
  let userId = params.getStr("userId")
  # let loginUserId = none(string)
  let loginUserId = "medy".some()

  let appPresenter = AppPresenter.new()
  let appViewModel = appPresenter.invoke(loginUserId, "Profile").await

  let profileViewModel = ProfileViewModel.new(loginUserId)
  let profileView = profileView(appViewModel, profileViewModel)
  return render(profileView)


proc islandProfile*(context:Context, params:Params):Future[Response] {.async.} =
  let userId = params.getStr("userId")
  # let loginUserId = none(string)
  let loginUserId = "medy".some()

  let profileViewModel = ProfileViewModel.new(loginUserId)
  let profileView = islandProfileView(profileViewModel)
  return render(profileView)


proc settings*(context:Context, params:Params):Future[Response] {.async.} =
  # let loginUserId = none(string)
  let loginUserId = "medy".some()

  let appPresenter = AppPresenter.new()
  let appViewModel = appPresenter.invoke(loginUserId, "Settings").await

  let settingView = settingView(appViewModel)
  return render(settingView)


proc islandSetting*(context:Context, params:Params):Future[Response] {.async.} =
  let settingView = islandSettingView()
  return render(settingView)


# proc article*(context:Context, params:Params):Future[Response] {.async.} =
#   let articleId = params.getStr("articleId")
#   let loginUserId =
#     if context.isLogin().await:
#       context.get("id").await.some()
#     else:
#       none(string)

#   let appPresenter = AppPresenter.new()
#   let appViewModel = appPresenter.invoke(loginUserId, "Article").await

#   let articleView = articleView(appViewModel)
#   return render(articleView)


# proc islandArticle*(context:Context, params:Params):Future[Response] {.async.} =
#   let articleView = islandArticleView()
#   return render(articleView)
