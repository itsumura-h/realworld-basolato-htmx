import std/asyncdispatch
from ../../../../config/database import rdb
import ../../../models/aggregates/article/article_repository_interface
import ../../../models/aggregates/article/vo/article_id


type ArticleRepository = object of IArticleRepository

proc init*(_:type ArticleRepository):ArticleRepository =
  return ArticleRepository()


method isExistsArticle*(self:ArticleRepository, articleId:ArticleId):Future[bool] {.async.} =
  return true
