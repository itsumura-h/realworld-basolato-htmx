import std/asyncdispatch
import std/sequtils
import allographer/query_builder
from ../../../../config/database import rdb
import ../../../models/dto/tag/tag_dao_interface
import ../../../models/dto/tag/tag_dto


type DbTagResponse = object
  id: string
  name: string
  popularCount: int


type TagDao* = object of ITagDao

proc new*(_:type TagDao): TagDao =
  return TagDao()


method getPopularTagList*(self: TagDao): Future[seq[TagDto]] {.async.} =
  let sql = """
    SELECT
      "tag"."id",
      "tag"."name",
      COUNT("id") as "popularCount"
    FROM "tag"
    JOIN "tag_article_map" ON "tag"."id" = "tag_article_map"."tag_id"
    GROUP BY "tag"."id", "tag"."name"
    ORDER BY "popularCount" DESC
    LIMIT 10
  """
  let dbTagList = rdb.raw(sql).get().orm(DbTagResponse).await
  
  let tagList = dbTagList.map(
    proc(tag:DbTagResponse):TagDto =
      return TagDto.new(tag.id, tag.name)
  )

  return tagList
