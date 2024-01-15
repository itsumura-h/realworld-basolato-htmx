import std/asyncdispatch
import std/json
import std/strformat
import allographer/query_builder
from ../../../config/database import rdb


type GetFavoriteTagsQuery* = ref object

proc new*(_:type GetFavoriteTagsQuery):GetFavoriteTagsQuery =
  return GetFavoriteTagsQuery()


proc invoke*(self:GetFavoriteTagsQuery, count:int):Future[seq[JsonNode]] {.async.} =
  let sql = &"""
   SELECT
    "tag"."id",
    "tag_name",
    COUNT("id") as "favorite_count"
   FROM "tag"
   JOIN "tag_article_map" ON "tag"."id" = "tag_article_map"."tag_id"
   GROUP BY "tag"."id"
   ORDER BY "favorite_count" DESC
   LIMIT {count}
  """
  let res = rdb.raw(sql).get().await
  return res
