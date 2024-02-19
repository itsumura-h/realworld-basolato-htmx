import std/asyncdispatch
import ../../../models/aggregates/article/article_repository_interface
import ../../../models/aggregates/article/vo/article_id


type MockArticleRepository*  = object of IArticleRepository

proc new*(_:type MockArticleRepository):MockArticleRepository =
  return MockArticleRepository()


method isExistsArticle*(self:MockArticleRepository, articleId:ArticleId):Future[bool] {.async.} =
  return true
