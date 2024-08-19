import std/asyncdispatch
import std/times
import ../../../models/dto/article_detail/article_detail_query_interface
import ../../../models/dto/article_detail/article_detail_dto


type ArticleDetailQuery* = object of IArticleDetailQuery

proc new*(_:type ArticleDetailQuery): ArticleDetailQuery =
  return ArticleDetailQuery()


method getArticleById*(self: ArticleDetailQuery, articleId: string): Future[ArticleDetailDto] {.async.} =
  return ArticleDetailDto.new(
    id = articleId,
    title = "title",
    content = "content",
    createdAt = now(),
    updatedAt = now(),
    favoriteCount = 0
  )
