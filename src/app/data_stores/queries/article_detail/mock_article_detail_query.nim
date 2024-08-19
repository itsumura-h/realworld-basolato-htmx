import std/asyncdispatch
import std/times
import ../../../models/dto/article_detail/article_detail_dto
import ../../../models/dto/article_detail/article_detail_query_interface


type MockArticleDetailQuery* = object of IArticleDetailQuery

proc new*(_:type MockArticleDetailQuery): MockArticleDetailQuery =
  return MockArticleDetailQuery()


method getArticleById*(self: MockArticleDetailQuery, articleId: string): Future[ArticleDetailDto] {.async.} =
  return ArticleDetailDto.new(
    id = articleId,
    title = "title",
    content = "content",
    createdAt = now(),
    updatedAt = now(),
    favoriteCount = 0
  )
