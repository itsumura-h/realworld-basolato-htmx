import std/asyncdispatch
import std/json
import std/strformat
import allographer/query_builder
from ../../../config/database import rdb
import ../../usecases/get_popular_tags/get_popular_tags_dto


type GetPopularTagsQuery*  = object

proc init*(_:type GetPopularTagsQuery):GetPopularTagsQuery =
  return GetPopularTagsQuery()


proc invoke*(self:GetPopularTagsQuery, count:int):Future[seq[PopularTagDto]] {.async.} =
  let sql = &"""
    SELECT
      "tag"."id",
      "tag_name" as "name",
      COUNT("id") as "popularCount"
    FROM "tag"
    JOIN "tag_article_map" ON "tag"."id" = "tag_article_map"."tag_id"
    GROUP BY "tag"."id"
    ORDER BY "popularCount" DESC
    LIMIT {count}
  """
  let tagsJson = rdb.raw(sql).get().await
  var tags:seq[PopularTagDto]
  for row in tagsJson:
    tags.add(
      PopularTagDto.init(
        row["id"].getInt(),
        row["name"].getStr(),
        row["popularCount"].getInt(),
      )
    )

  return tags
