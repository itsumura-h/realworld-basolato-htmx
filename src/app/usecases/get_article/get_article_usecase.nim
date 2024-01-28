import std/asyncdispatch
import ../../models/aggregates/article/vo/article_id
import ../../models/aggregates/article/article_service
import ../../models/aggregates/article/article_repository_interface
import ../../errors
import ./get_article_query_interface
import ./get_article_dto


type GetArticleUsecase* = object
  query:IGetArticleQuery
  repository:IArticleRepository

proc new*(_:type GetArticleUsecase, query:IGetArticleQuery, repository:IArticleRepository):GetArticleUsecase =
  return GetArticleUsecase(
    query:query,
    repository:repository
  )


proc invoke*(self:GetArticleUsecase, articleId:string):Future[GetArticleDto] {.async.} =
  let articleId = ArticleId.new(articleId)
  let service = ArticleService.new(self.repository)
  if not service.isExistsArticle(articleId).await:
    raise newException(IdNotFoundError, "article is not found")
  let dto = self.query.invoke(articleId).await
  return dto
