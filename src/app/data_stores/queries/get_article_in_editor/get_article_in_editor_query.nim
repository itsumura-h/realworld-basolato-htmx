import std/asyncdispatch
import std/options
import std/json
import std/sequtils
import allographer/query_builder
import ../../../errors
from ../../../../config/database import rdb
import ../../../usecases/get_article_in_editor/get_article_in_editor_query_interface
import ../../../usecases/get_article_in_editor/get_article_in_editor_dto
import ../../../models/aggregates/article/vo/article_id


type GetArticleInEditorQuery* = object of IGetArticleInEditorQuery

proc new*(_:type GetArticleInEditorQuery): GetArticleInEditorQuery =
  return GetArticleInEditorQuery()


method invoke*(self:GetArticleInEditorQuery, articleId:ArticleId): Future[ArticleInEditorDto] {.async.} =
  let articleOpt = rdb.table("article")
                    .find(articleId.value)
                    .await
  if not articleOpt.isSome:
    raise newException(IdNotFoundError, "")

  let articleData = articleOpt.get()

  let tagsData = rdb.table("tag")
                .join("tag_article_map", "tag_article_map.tag_id", "=", "tag.id")
                .where("tag_article_map.article_id", "=", articleId.value)
                .get()
                .await

  let tags = tagsData.map(
    proc(tagData:JsonNode): TagDto =
      return TagDto.new(tagData["name"].getStr)
  )
  
  return ArticleInEditorDto.new(
    articleData["id"].getStr,
    articleData["title"].getStr,
    articleData["body"].getStr,
    articleData["description"].getStr,
    tags,
  )
