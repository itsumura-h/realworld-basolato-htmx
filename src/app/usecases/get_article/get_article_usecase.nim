import std/asyncdispatch
import std/options
import ../../models/aggregates/article/vo/article_id
import ../../models/aggregates/article/article_service
import ../../models/aggregates/article/article_repository_interface
import ../../models/aggregates/user/vo/user_id
import ../../errors
import ./get_article_query_interface
import ./get_article_dto


type GetArticleUsecase* = object
  query:IGetArticleQuery
  repository:IArticleRepository

proc init*(_:type GetArticleUsecase, query:IGetArticleQuery, repository:IArticleRepository):GetArticleUsecase =
  return GetArticleUsecase(
    query:query,
    repository:repository
  )


proc invoke*(self:GetArticleUsecase, articleId:string, loginUserId:string):Future[GetArticleDto] {.async.} =
  let articleId = ArticleId.init(articleId)
  let loginUserId =
    if loginUserId.len > 0:
      UserId.init(loginUserId).some()
    else:
      none(UserId)
  let service = ArticleService.init(self.repository)
  if not service.isExistsArticle(articleId).await:
    raise newException(IdNotFoundError, "article is not found")
  let dto = self.query.invoke(articleId, loginUserId).await
  return dto
