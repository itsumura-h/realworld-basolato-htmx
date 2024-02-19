import std/asyncdispatch
import std/options
import ../../models/aggregates/article/vo/article_id
import ../../models/aggregates/article/article_service
import ../../models/aggregates/article/article_repository_interface
import ../../models/aggregates/user/vo/user_id
import ../../errors
import ./get_article_in_feed_query_interface
import ./get_article_in_feed_dto


type GetArticleInFeedUsecase*  = object
  query:IGetArticleInFeedQuery
  repository:IArticleRepository

proc new*(_:type GetArticleInFeedUsecase, query:IGetArticleInFeedQuery, repository:IArticleRepository):GetArticleInFeedUsecase =
  return GetArticleInFeedUsecase(
    query:query,
    repository:repository
  )


proc invoke*(self:GetArticleInFeedUsecase, articleId:string, loginUserId:string):Future[GetArticleInFeedDto] {.async.} =
  let articleId = ArticleId.new(articleId)
  let loginUserId =
    if loginUserId.len > 0:
      UserId.new(loginUserId).some()
    else:
      none(UserId)
  let service = ArticleService.new(self.repository)
  if not service.isExistsArticle(articleId).await:
    raise newException(IdNotFoundError, "article is not found")
  let dto = self.query.invoke(articleId, loginUserId).await
  return dto
