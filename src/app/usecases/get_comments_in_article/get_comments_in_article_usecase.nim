import std/asyncdispatch
import ./get_comments_in_article_dto
import ./get_comments_in_article_query_interface


type GetCommentsInArticleUsecase* = object
  query:IGetCommentsInArticleQuery

proc new*(_:type GetCommentsInArticleUsecase, query:IGetCommentsInArticleQuery):GetCommentsInArticleUsecase =
  return GetCommentsInArticleUsecase(
    query:query
  )


proc invoke*(self:GetCommentsInArticleUsecase, articleId:string):Future[GetCommentsInArticleDto] {.async.} =
  let dto = self.query.invoke(articleId).await
  return dto
