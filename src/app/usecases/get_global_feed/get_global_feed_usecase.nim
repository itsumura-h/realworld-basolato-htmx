import std/asyncdispatch
import ../../data_stores/queries/get_articles_with_author_query
import ../../data_stores/queries/get_global_feed_paginator_query
import ./get_global_feed_dto

type GetGlobalFeedUsecase* = object

proc init*(_:type GetGlobalFeedUsecase):GetGlobalFeedUsecase =
  return GetGlobalFeedUsecase()


proc invoke*(self:GetGlobalFeedUsecase, page:int):Future[GlobalFeedDto] {.async.} =
  let getArticlesWithAuthorQuery = GetArticlesWithAuthorQuery.init()
  let articlesWithAuthor = getArticlesWithAuthorQuery.invoke(page).await

  let getGlobalFeedPaginatorQuery = GetGlobalFeedPaginatorQuery.init()
  let globalFeedPaginator = getGlobalFeedPaginatorQuery.invoke(page).await

  let globalFeedDto = GlobalFeedDto.init(
    articlesWithAuthor,
    globalFeedPaginator
  )
  return globalFeedDto
