import std/asyncdispatch
import std/strformat
import ../../models/dto/article_with_author/your_feed_article_list_query_interface
import ../../models/dto/paginator/your_feed_article_list_paginator_query_interface
import ../../models/dto/favorite_button/favorite_button_query_interface
import ../../models/vo/article_id
import ../../models/vo/user_id
import ../../http/views/islands/feed/feed_view_model
import ../../http/views/components/article_preview/article_preview_view_model
import ../../http/views/islands/simple_favorite_button/simple_favorite_button_view_model
import ../../http/views/components/feed_navbar/feed_navbar_view_model
import ../../http/views/components/paginator/paginator_view_model
import ../../di_container


type YourFeedPresenter* = object
  yourFeedArticleListQuery:IYourFeedArticleListQuery
  paginatorQuery: IYourFeedArticleListPaginatorQuery
  favoriteButtonQuery: IFavoriteButtonQuery

proc new*(_:type YourFeedPresenter):YourFeedPresenter =
  return YourFeedPresenter(
    yourFeedArticleListQuery: di.yourFeedArticleListQuery,
    paginatorQuery: di.yourFeedPaginatorQuery,
    favoriteButtonQuery: di.favoriteButtonQuery
  )


proc invoke*(
  self:YourFeedPresenter,
  page:int,
  loginUserId:string,
):Future[FeedViewModel] {.async.} =
  const display = 5
  let offset = (page - 1) * display
  let loginUserId = UserId.new(loginUserId)
  let articleWithAuthorDtoList = self.yourFeedArticleListQuery.invoke(loginUserId, offset, display).await

  var articleList:seq[ArticlePreviewViewModel]
  for articleWithAuthorDto in articleWithAuthorDtoList:
    let articleId = ArticleId.new(articleWithAuthorDto.id)
    let favoriteButtonDto = self.favoriteButtonQuery.invoke(articleId, loginUserId).await
    let favoriteButtonViewModel = SimpleFavoriteButtonViewModel.new(favoriteButtonDto)
    articleList.add(
      ArticlePreviewViewModel.new(articleWithAuthorDto, favoriteButtonViewModel)
    )

  let paginatorDto = self.paginatorQuery.invoke(loginUserId, page, display).await
  let paginatorViewModel = PaginatorViewModel.new(paginatorDto, &"/island/home/your-feed", "/your-feed")

  let feedNavbarViewModel = FeedNavbarViewModel.yourFeed(loginUserId.value)

  let viewModel = FeedViewModel.new(articleList, paginatorViewModel, feedNavbarViewModel)
  return viewModel
