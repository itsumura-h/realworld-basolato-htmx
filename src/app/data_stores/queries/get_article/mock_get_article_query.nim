import std/asyncdispatch
import std/times
import ../../../usecases/get_article/get_article_query_interface
import ../../../usecases/get_article/get_article_dto


type MockGetArticleQuery* = object of IGetArticleQuery

proc new*(_:type MockGetArticleQuery):MockGetArticleQuery =
  return MockGetArticleQuery()


method invoke*(self:MockGetArticleQuery, articleId:string):Future[GetArticleDto] {.async.} =
  let tags = @[
    TagDto.new(
      1,
      "article-id-1",
      "tag name 1"
    ),
    TagDto.new(
      2,
      "article-id-1",
      "tag name 2"
    ),
  ]

  let article = ArticleDto.new(
    "article-id-1",
    "titie",
    "description",
    "body",
    "2024-01-01 12:00:00",
    tags
  )
  let user = UserDto.new(
    "user-name",
    "user name",
    ""
  )
  let dto = GetArticleDto.new(
    article,
    user
  )
  return dto
