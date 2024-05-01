import std/asyncdispatch
import ../../http/views/pages/home/htmx_article_preview/htmx_article_preview_view_model
import ../../http/views/components/home/favorite_button/favorite_button_view_model
import ../../http/views/components/home/feed_navigation/feed_navigation_view_model
import ../../http/views/components/paginator/paginator_view_model
import ../../models/dto/article_with_author/global_feed_article_list_query_interface
import ../../models/dto/paginator/global_feed_article_list_paginator_query_interface
import ../../models/dto/favorite_button/favorite_button_query_interface
import ../../models/vo/article_id
import ../../models/vo/user_id
import ../../di_container


type GlobalFeedArticleListPresenter* = object
  globalFeedArticleListQuery:IGlobalFeedArticleListQuery
  paginatorQuery: IGlobalFeedArticleListPaginatorQuery
  favoriteButtonQuery: IFavoriteButtonQuery

proc new*(_:type GlobalFeedArticleListPresenter):GlobalFeedArticleListPresenter =
  return GlobalFeedArticleListPresenter(
    globalFeedArticleListQuery: di.globalFeedArticleListQuery,
    paginatorQuery: di.globalFeedPaginatorQuery,
    favoriteButtonQuery: di.favoriteButtonQuery
  )


proc invoke*(
  self:GlobalFeedArticleListPresenter,
  page:int,
  isLogin:bool,
  loginUserId:string
):Future[HtmxArticlePreviewViewModel] {.async.} =
  const display = 5
  let offset = (page - 1) * display
  let articleWithAuthorDtoList = self.globalFeedArticleListQuery.invoke(offset, display).await

  var articleList:seq[Article]
  for articleWithAuthorDto in articleWithAuthorDtoList:
    let articleId = ArticleId.new(articleWithAuthorDto.id)

    let favoriteButtonDto =
      if isLogin:
        let loginUserId = UserId.new(loginUserId)
        self.favoriteButtonQuery.invoke(articleId, loginUserId).await
      else:
        self.favoriteButtonQuery.invoke(articleId).await

    let favoriteButtonViewModel = FavoriteButtonViewModel.new(favoriteButtonDto)
    articleList.add(
      Article.new(articleWithAuthorDto, favoriteButtonViewModel)
    )

  let paginatorDto = self.paginatorQuery.invoke(page, display).await
  let paginatorViewModel = PaginatorViewModel.new(paginatorDto, "/htmx/home/global-feed")

  var feedNavbarViewModelList = @[
    FeedNavbarViewModel.new(
      title = "Global Feed",
      isActive = true,
      hxGetUrl = "/htmx/home/global-feed",
      hxPushUrl = "/"
    )
  ]

  if isLogin:
    feedNavbarViewModelList.insert(
      FeedNavbarViewModel.new(
        title = "Your Feed",
        isActive = false,
        hxGetUrl = "/htmx/home/your-feed",
        hxPushUrl = "/your-feed"
      ),
      0
    )

  let viewModel = HtmxArticlePreviewViewModel.new(articleList, paginatorViewModel, feedNavbarViewModelList)
  return viewModel
