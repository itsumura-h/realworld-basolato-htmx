import std/asyncdispatch
import std/json
import std/strformat
import allographer/query_builder
from ../../../config/database import rdb
import ../../usecases/get_popular_tags/get_popular_tags_dto


type GetPopularTagsQuery*  = object

proc new*(_:type GetPopularTagsQuery):GetPopularTagsQuery =
  return GetPopularTagsQuery()


proc invoke*(self:GetPopularTagsQuery, count:int):Future[seq[PopularTagDto]] {.async.} =
  let sql = &"""
    SELECT
      "tag"."id",
      "tag"."name",
      COUNT("id") as "popularCount"
    FROM "tag"
    JOIN "tag_article_map" ON "tag"."id" = "tag_article_map"."tag_id"
    GROUP BY "tag"."id", "tag"."name"
    ORDER BY "popularCount" DESC
    LIMIT {count}
  """
  let tagsJson = rdb.raw(sql).get().await
  var tags:seq[PopularTagDto]
  for row in tagsJson:
    tags.add(
      PopularTagDto.new(
        row["id"].getStr(),
        row["name"].getStr(),
        row["popularCount"].getInt(),
      )
    )

  return tags
