import std/asyncdispatch
import ./article_repository_interface
import ./vo/article_id


type ArticleService*  = object
  repository:IArticleRepository

proc init*(_:type ArticleService, repository:IArticleRepository):ArticleService =
  return ArticleService(
    repository:repository
  )


proc isExistsArticle*(self:ArticleService, articleId:ArticleId):Future[bool] {.async.} =
  return self.repository.isExistsArticle(articleId).await
