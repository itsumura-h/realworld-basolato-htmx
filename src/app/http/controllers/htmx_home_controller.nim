import std/asyncdispatch
# framework
import basolato/controller
import basolato/view
# global feed
import ../../usecases/get_global_feed/get_global_feed_usecase
import ../views/pages/home/home_view_model
import ../views/pages/home/home_view
import ../views/pages/home/htmx_post_preview/htmx_post_preview_view_model
import ../views/pages/home/htmx_post_preview/htmx_post_preview_view
# tag feed
import ../../usecases/get_tag_feed/get_tag_feed_usecase
# tag list
import ../../usecases/get_popular_tags/get_popular_tags_usecase
import ../views/pages/home/htmx_tag_item_list/htmx_tag_item_list_view_model
import ../views/pages/home/htmx_tag_item_list/htmx_tag_item_list_view
# your feed
import ../../usecases/get_your_feed/get_your_feed_usecase
# favorite
import ../../usecases/favorite_usecase
import ../../usecases/get_favorite_button/get_favorite_button_usecase
import ../views/components/home/favorite_button/favorite_button_view_model
import ../views/components/home/favorite_button/favorite_button_view


proc index*(context:Context, params:Params):Future[Response] {.async.} =
  let viewModel = HomeViewModel.new()
  let view = htmxHomeView(viewModel)
  return render(view)


proc globalFeed*(context:Context, params:Params):Future[Response] {.async.} =
  let page =
    if params.hasKey("page"):
      params.getInt("page")
    else:
      1
  let isLogin = context.isLogin().await
  let usecase = GetGlobalFeedUsecase.new()
  let dto = usecase.invoke(page).await
  let viewModel = HtmxPostPreviewViewModel.new(dto, isLogin)
  let view = htmxPostPreviewView(viewModel)
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

  let usecase = GetYourFeedUsecase.new()
  let dto = usecase.invoke(userId, page).await
  let viewModel = HtmxPostPreviewViewModel.new(dto)
  let view = htmxPostPreviewView(viewModel)
  return render(view)


proc tagFeed*(context:Context, params:Params):Future[Response] {.async.} =
  let tagName = params.getStr("tagName")
  let page =
    if params.hasKey("page"):
      params.getInt("page")
    else:
      1
  let isLogin = context.isLogin().await
  let usecase = GetTagFeedUsecase.new()
  let dto = usecase.invoke(tagName, page).await
  let viewModel = HtmxPostPreviewViewModel.new(dto, tagName, isLogin)
  let view = htmxPostPreviewView(viewModel)
  return render(view)


proc tagList*(context:Context, params:Params):Future[Response] {.async.} =
  let usecase = GetPopularTagsUsecase.new()
  let tagsDto = usecase.invoke().await
  let viewModel = HtmxTagItemListViewModel.new(tagsDto)
  let view = htmxTagListView(viewModel)
  return render(view)


proc favorite*(context:Context, params:Params):Future[Response] {.async.} =
  let articleId = params.getStr("articleId")
  let loginUserId = context.get("id").await
  try:
    let followUsecase = FavoriteUsecase.new()
    followUsecase.invoke(articleId, loginUserId).await

    let getFavoriteButtonUsecase = GetFavoriteButtonUsecase.new()
    let dto = getFavoriteButtonUsecase.invoke(articleId, loginUserId).await
    let viewModel = FavoriteButtonViewModel.new(dto)
    let view = favoriteButtonView(viewModel)
    return render(view)
  except:
    return render(Http400, getCurrentExceptionMsg())
