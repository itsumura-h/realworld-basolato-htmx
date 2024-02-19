import std/asyncdispatch
import std/times
import std/json
import std/options
import allographer/query_builder
from ../../../../config/database import rdb
import ../../../models/aggregates/article/article_repository_interface
import ../../../models/aggregates/article/vo/article_id
import ../../../models/aggregates/article/article_entity


type ArticleRepository = object of IArticleRepository

proc init*(_:type ArticleRepository):ArticleRepository =
  return ArticleRepository()


method isExistsArticle*(self:ArticleRepository, articleId:ArticleId):Future[bool] {.async.} =
  let articleOpt = rdb.table("article").find(articleId.value).await
  return articleOpt.isSome()


method create*(self:ArticleRepository, article:DraftArticle) {.async.} =
  rdb.table("articles").insert(%*{
    "id": article.articleId.value,
    "title": article.title.value,
    "description": article.description.value,
    "body": article.body.value,
    "author_id": article.userId.value,
    "created_at": article.createdAt.format("yyyy-MM-dd hh:mm:ss"),
    "updated_at": article.updatedAt.format("yyyy-MM-dd hh:mm:ss"),
  })
  .await
