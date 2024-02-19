import std/asyncdispatch
import ../../errors
import ../../di_container
import ../../models/aggregates/article/vo/article_id
import ../../models/aggregates/article/article_service
import ./get_article_in_editor_query_interface
import ./get_article_in_editor_dto


type GetArticleInEditorUsecase* = object
  query:IGetArticleInEditorQuery
  service:ArticleService

proc new*(_:type GetArticleInEditorUsecase): GetArticleInEditorUsecase =
  let repository = di.articleRepository
  return GetArticleInEditorUsecase(
    query: di.getArticleInEditorQuery,
    service: ArticleService.new(repository)
  )


proc invoke*(self:GetArticleInEditorUsecase, articleId:string):Future[ArticleInEditorDto] {.async.} =
  let articleId = ArticleId.new(articleId)

  if not self.service.isExistsArticle(articleId).await:
    raise newException(DomainError, "Article not found")

  let dto = self.query.invoke(articleId).await
  return dto
