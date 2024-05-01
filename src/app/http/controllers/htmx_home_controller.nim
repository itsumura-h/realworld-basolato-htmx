import std/asyncdispatch
# framework
import basolato/controller
import basolato/view
# global feed
# import ../../usecases/get_global_feed/get_global_feed_usecase
import ../views/pages/home/home_view
import ../views/pages/home/htmx_article_preview/htmx_article_preview_view
#
import ../../presenters/home/global_feed_presenter

import ../../presenters/htmx_article_preview/global_feed_article_list_presenter
import ../../presenters/htmx_article_preview/your_feed_article_list_presenter
# import ../../presenters/htmx_article_preview/your_feed_article_list_presenter
# # tag feed
# import ../../presenters/htmx_article_preview/tag_feed_article_list_presenter
# tag list
import ../../presenters/popular_tag_list/popular_tag_list_presenter
import ../views/pages/home/htmx_tag_list/htmx_tag_list_view
# # favorite
# import ../../usecases/favorite_usecase
# import ../views/components/home/favorite_button/favorite_button_view_model
# import ../views/components/home/favorite_button/favorite_button_view

# import ../../presenters/home_favorite_button/home_favorite_button_presenter


proc index*(context:Context, params:Params):Future[Response] {.async.} =
  let presenter = GlobalFeedPresenter.new()
  let viewModel = presenter.invoke()
  let view = htmxHomeView(viewModel)
  return render(view)


proc globalFeed*(context:Context, params:Params):Future[Response] {.async.} =
  let page =
    if params.hasKey("page"):
      params.getInt("page")
    else:
      1
  let isLogin = context.isLogin().await
  let loginUserId = context.get("id").await

  let presenter = GlobalFeedArticleListPresenter.new()
  let viewModel = presenter.invoke(page, isLogin, loginUserId).await
  let view = htmxArticlePreviewView(viewModel)
  return render(view)


proc yourFeed*(context:Context, params:Params):Future[Response] {.async.} =
  let page =
    if params.hasKey("page"):
      params.getInt("page")
    else:
      1

  let userId =
    if context.isSome("id").await:
      context.get("id").await
    else:
      return render(Http403, "Forbidden")

  let presenter = YourFeedArticleListPresenter.new()
  let viewModel = presenter.invoke(userId, page).await
  let view = htmxArticlePreviewView(viewModel)
  return render(view)


# proc tagFeed*(context:Context, params:Params):Future[Response] {.async.} =
#   let tagName = params.getStr("tagName")
#   let page =
#     if params.hasKey("page"):
#       params.getInt("page")
#     else:
#       1
#   let isLogin = context.isLogin().await
#   let usecase = GetTagFeedUsecase.new()
#   let dto = usecase.invoke(tagName, page).await
#   let viewModel = HtmxArticlePreviewViewModel.new(dto, tagName, isLogin)
#   let view = htmxArticlePreviewView(viewModel)
#   return render(view)


proc tagList*(context:Context, params:Params):Future[Response] {.async.} =
  let presenter = PopularTagListPresenter.new()
  let viewModel = presenter.invoke().await
  let view = htmxTagListView(viewModel)
  return render(view)


# proc favorite*(context:Context, params:Params):Future[Response] {.async.} =
#   let articleId = params.getStr("articleId")
#   let isLogin = context.isLogin().await
#   let loginUserId = context.get("id").await
#   try:
#     let followUsecase = FavoriteUsecase.new()
#     followUsecase.invoke(articleId, loginUserId).await

#     let presenter = HomeFavoriteButtonPresenter.new()
#     let viewModel = presenter.invoke(articleId, isLogin, loginUserId).await
#     let view = favoriteButtonView(viewModel)
#     return render(view)
#   except:
#     return render(Http400, getCurrentExceptionMsg())
