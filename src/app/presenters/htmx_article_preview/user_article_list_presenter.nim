import std/asyncdispatch
import std/strformat
import ../../models/dto/user/user_query_interface
import ../../models/dto/article_with_author/user_article_list_query_interface
import ../../models/dto/paginator/user_article_list_paginator_query_interface
import ../../models/dto/favorite_button/favorite_button_query_interface
import ../../models/vo/article_id
import ../../models/vo/user_id
import ../../http/views/pages/home/htmx_article_preview/htmx_article_preview_view_model
import ../../http/views/components/paginator/paginator_view_model
import ../../http/views/components/home/favorite_button/favorite_button_view_model
import ../../http/views/components/home/feed_navigation/feed_navigation_view_model
import ../../di_container


type UserArticleListPresenter* = object
  userQuery:IUserQuery
  userArticleListQuery:IUserArticleListQuery
  paginatorQuery: IUserArticleListPaginatorQuery
  favoriteButtonQuery: IFavoriteButtonQuery

proc new*(_:type UserArticleListPresenter):UserArticleListPresenter =
  return UserArticleListPresenter(
    userQuery: di.userQuery,
    userArticleListQuery: di.userArticleListQuery,
    paginatorQuery: di.userPaginatorQuery,
    favoriteButtonQuery: di.favoriteButtonQuery
  )


proc invoke*(
  self:UserArticleListPresenter,
  page:int,
  userId:string,
  isLogin:bool,
  loginUserId:string
):Future[HtmxArticlePreviewViewModel] {.async.} =
  let userId = UserId.new(userId)
  let userDto = self.userQuery.invoke(userId).await

  const display = 5
  let offset = (page - 1) * display
  let loginUserId = UserId.new(loginUserId)
  let articleWithAuthorDtoList = self.userArticleListQuery.invoke(loginUserId, offset, display).await

  var articleList:seq[Article]
  for articleWithAuthorDto in articleWithAuthorDtoList:
    let articleId = ArticleId.new(articleWithAuthorDto.id)

    let favoriteButtonDto =
      if isLogin:
        self.favoriteButtonQuery.invoke(articleId, loginUserId).await
      else:
        self.favoriteButtonQuery.invoke(articleId).await

    let favoriteButtonViewModel = FavoriteButtonViewModel.new(favoriteButtonDto)
    articleList.add(
      Article.new(articleWithAuthorDto, favoriteButtonViewModel)
    )

  let paginatorDto = self.paginatorQuery.invoke(loginUserId, page, display).await
  let paginatorViewModel = PaginatorViewModel.new(paginatorDto, &"/htmx/home/{}")
