import std/asyncdispatch
import ../../data_stores/queries/get_popular_tags_query
import ./get_popular_tags_dto


type GetPopularTagsUsecase* = object

proc new*(_:type GetPopularTagsUsecase):GetPopularTagsUsecase =
  return GetPopularTagsUsecase()


proc invoke*(self:GetPopularTagsUsecase):Future[seq[PopularTagDto]] {.async.} =
  let getPopularTagsQuery = GetPopularTagsQuery.new()
  let popularTags = getPopularTagsQuery.invoke(5).await
  return popularTags
