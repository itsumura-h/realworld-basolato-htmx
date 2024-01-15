import std/asyncdispatch
import std/json
import std/strformat
import allographer/query_builder
from ../../../config/database import rdb
import ../../http/views/pages/home/htmx_tag_item_list_view_model


type GetPopularTagsQuery* = object

proc new*(_:type GetPopularTagsQuery):GetPopularTagsQuery =
  return GetPopularTagsQuery()


proc invoke*(self:GetPopularTagsQuery, count:int):Future[HtmxTagItemListViewModel] {.async.} =
  let sql = &"""
    SELECT
      "tag"."id",
      "tag_name" as "name",
      COUNT("id") as "popularTagsCount"
    FROM "tag"
    JOIN "tag_article_map" ON "tag"."id" = "tag_article_map"."tag_id"
    GROUP BY "tag"."id"
    ORDER BY "popularTagsCount" DESC
    LIMIT {count}
  """
  let tagsJson = rdb.raw(sql).get().await
  var tags:seq[Tag]
  for row in tagsJson:
    tags.add(
      Tag.new(
        row["id"].getInt(),
        row["name"].getStr(),
        row["popularTagsCount"].getInt(),
      )
    )

  let viewMolde = HtmxTagItemListViewModel.new(tags)
  return viewMolde
