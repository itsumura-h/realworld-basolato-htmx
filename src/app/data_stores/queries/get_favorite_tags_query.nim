import std/asyncdispatch
import std/json
import std/strformat
import allographer/query_builder
from ../../../config/database import rdb
import ../../http/views/pages/home/htmx_tag_item_list_view_model


type GetFavoriteTagsQuery* = ref object

proc new*(_:type GetFavoriteTagsQuery):GetFavoriteTagsQuery =
  return GetFavoriteTagsQuery()


proc invoke*(self:GetFavoriteTagsQuery, count:int):Future[HtmxTagItemListViewModel] {.async.} =
  let sql = &"""
    SELECT
      "tag"."id",
      "tag_name" as "name",
      COUNT("id") as "favoriteCount"
    FROM "tag"
    JOIN "tag_article_map" ON "tag"."id" = "tag_article_map"."tag_id"
    GROUP BY "tag"."id"
    ORDER BY "favoriteCount" DESC
    LIMIT {count}
  """
  let tagsJson = rdb.raw(sql).get().await
  var tags:seq[Tag]
  for row in tagsJson:
    tags.add(
      Tag.new(
        row["id"].getInt(),
        row["name"].getStr(),
        row["favoriteCount"].getInt(),
      )
    )

  let viewMolde = HtmxTagItemListViewModel.new(tags)
  return viewMolde
