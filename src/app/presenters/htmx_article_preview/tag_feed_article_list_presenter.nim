import std/asyncdispatch
import std/strformat
import ../../http/views/pages/home/htmx_article_preview/htmx_article_preview_view_model
import ../../http/views/components/home/favorite_button/favorite_button_view_model
import ../../http/views/components/home/feed_navigation/feed_navigation_view_model
import ../../http/views/components/paginator/paginator_view_model
import ../../models/dto/article_with_author/tag_feed_article_list_query_interface
import ../../models/dto/paginator/tag_feed_article_list_paginator_query_interface
import ../../models/dto/favorite_button/favorite_button_query_interface
import ../../models/vo/article_id
import ../../models/vo/user_id
import ../../di_container


type TagFeedArticleListPresenter* = object
  tagFeedArticleListQuery:ITagFeedArticleListQuery
  paginator:ITagFeedArticleListPaginatorQuery
  favoriteButtonQuery: IFavoriteButtonQuery

proc new*(_:type TagFeedArticleListPresenter):TagFeedArticleListPresenter =
  return TagFeedArticleListPresenter(
    tagFeedArticleListQuery: di.tagFeedArticleListQuery,
    paginator: di.tagFeedPaginatorQuery,
    favoriteButtonQuery: di.favoriteButtonQuery
  )


proc invoke*(self:TagFeedArticleListPresenter, tagName:string, page:int, isLogin:bool, loginUserId:string):Future[HtmxArticlePreviewViewModel] {.async.} =
  const display = 5
  let offset = (page - 1) * display
  let articleWithAuthorDtoList = self.tagFeedArticleListQuery.invoke(tagName, offset, display).await

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

  let paginatorDto = self.paginator.invoke(tagName, page, display).await
  let paginatorViewModel = PaginatorViewModel.new(paginatorDto, &"/htmx/home/tag-feed/{tagName}")

  var feedNavbarViewModelList = @[
    FeedNavbarViewModel.new(
      title = "Tag Feed",
      isActive = true,
      hxGetUrl = &"/htmx/home/tag-feed/{tagName}",
      hxPushUrl = "/"
    ),
    FeedNavbarViewModel.new(
      title = "Global Feed",
      isActive = false,
      hxGetUrl = "/htmx/home/global-feed",
      hxPushUrl = "/"
    )
  ]

  if isLogin:
    feedNavbarViewModelList.add(
      FeedNavbarViewModel.new(
        title = "Your Feed",
        isActive = false,
        hxGetUrl = "/htmx/home/your-feed",
        hxPushUrl = "/your-feed"
      )
    )

  let viewModel = HtmxArticlePreviewViewModel.new(articleList, paginatorViewModel, feedNavbarViewModelList)
  return viewModel
