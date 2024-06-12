import std/asyncdispatch
import std/options
import ../../models/dto/article_with_author/global_feed_article_list_query_interface
import ../../models/dto/paginator/global_feed_article_list_paginator_query_interface
import ../../models/dto/favorite_button/favorite_button_query_interface
import ../../models/vo/article_id
import ../../models/vo/user_id
import ../../http/views/islands/feed/feed_view_model
import ../../http/views/components/article_preview/article_preview_view_model
import ../../http/views/islands/simple_favorite_button/simple_favorite_button_view_model
import ../../http/views/components/feed_navbar/feed_navbar_view_model
import ../../http/views/components/paginator/paginator_view_model
import ../../di_container


type GlobalFeedPresenter* = object
  globalFeedArticleListQuery:IGlobalFeedArticleListQuery
  paginatorQuery: IGlobalFeedArticleListPaginatorQuery
  favoriteButtonQuery: IFavoriteButtonQuery

proc new*(_:type GlobalFeedPresenter):GlobalFeedPresenter =
  return GlobalFeedPresenter(
    globalFeedArticleListQuery: di.globalFeedArticleListQuery,
    paginatorQuery: di.globalFeedPaginatorQuery,
    favoriteButtonQuery: di.favoriteButtonQuery
  )


proc invoke*(
  self:GlobalFeedPresenter,
  page:int,
  loginUserId:Option[string]
):Future[FeedViewModel] {.async.} =
  const display = 5
  let offset = (page - 1) * display
  let articleWithAuthorDtoList = self.globalFeedArticleListQuery.invoke(offset, display).await

  var articleList:seq[ArticlePreviewViewModel]
  for articleWithAuthorDto in articleWithAuthorDtoList:
    let articleId = ArticleId.new(articleWithAuthorDto.id)

    let favoriteButtonDto =
      if loginUserId.isSome():
        let loginUserId = UserId.new(loginUserId.get())
        self.favoriteButtonQuery.invoke(articleId, loginUserId).await
      else:
        self.favoriteButtonQuery.invoke(articleId).await

    let favoriteButtonViewModel = SimpleFavoriteButtonViewModel.new(favoriteButtonDto)
    articleList.add(
      ArticlePreviewViewModel.new(articleWithAuthorDto, favoriteButtonViewModel)
    )

  let paginatorDto = self.paginatorQuery.invoke(page, display).await
  let paginatorViewModel = PaginatorViewModel.new(paginatorDto, "/island/feed/global-feed", "/")

  let feedNavbarViewModel = FeedNavbarViewModel.globalFeed(loginUserId)

  let viewModel = FeedViewModel.new(articleList, paginatorViewModel, feedNavbarViewModel)
  return viewModel
