import std/asyncdispatch
import std/strformat
import allographer/query_builder
from ../../../../config/database import rdb
import ../../../models/dto/tag/tag_list_query_interface
import ../../../models/dto/tag/tag_dto

type PopularTagListQuery* = object of ITagListQuery

proc new*(_:type PopularTagListQuery):PopularTagListQuery =
  return PopularTagListQuery()


method invoke*(self:PopularTagListQuery, count:int):Future[seq[TagDto]] {.async.} =
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
  let tagList = rdb.raw(sql).get().orm(TagDto).await
  return tagList
