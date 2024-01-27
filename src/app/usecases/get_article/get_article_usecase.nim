import std/asyncdispatch
import ./get_article_query_interface
import ./get_article_dto


type GetArticleUsecase* = object
  query:IGetArticleQuery

proc new*(_:type GetArticleUsecase, query:IGetArticleQuery):GetArticleUsecase =
  return GetArticleUsecase(
    query:query
  )


proc invoke*(self:GetArticleUsecase, articleId:string):Future[GetArticleDto] {.async.} =
  let dto = self.query.invoke(articleId).await
  return dto
