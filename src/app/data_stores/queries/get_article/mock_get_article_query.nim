import std/asyncdispatch
import std/times
import ../../../usecases/get_article/get_article_query_interface
import ../../../usecases/get_article/get_article_dto
import ../../../models/aggregates/article/vo/article_id


type MockGetArticleQuery* = object of IGetArticleQuery

proc new*(_:type MockGetArticleQuery):MockGetArticleQuery =
  return MockGetArticleQuery()


method invoke*(self:MockGetArticleQuery, articleId:ArticleId):Future[GetArticleDto] {.async.} =
  let tags = @[
    TagDto.new(
      1,
      articleId.value,
      "tag name 1"
    ),
    TagDto.new(
      2,
      articleId.value,
      "tag name 2"
    ),
  ]

  let article = ArticleDto.new(
    articleId.value,
    "titie",
    "description",
    "body",
    "2024-01-01 12:00:00",
    tags
  )
  let user = UserDto.new(
    "user-name",
    "user name",
    "",
    5
  )
  let dto = GetArticleDto.new(
    article,
    user
  )
  return dto
