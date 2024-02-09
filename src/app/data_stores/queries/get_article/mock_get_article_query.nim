import std/asyncdispatch
import std/times
import std/options
import ../../../usecases/get_article/get_article_query_interface
import ../../../usecases/get_article/get_article_dto
import ../../../models/aggregates/article/vo/article_id
import ../../../models/aggregates/user/vo/user_id


type MockGetArticleQuery* = object of IGetArticleQuery

proc new*(_:type MockGetArticleQuery):MockGetArticleQuery =
  return MockGetArticleQuery()


method invoke*(self:MockGetArticleQuery, articleId:ArticleId, loginUserId:Option[UserId]):Future[GetArticleDto] {.async.} =
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
    id = articleId.value,
    title = "titie",
    description = "description",
    body = "body",
    createdAt = "2024-01-01 12:00:00",
    tags = tags,
    isFavorited = false,
    favoriteCount = 5,
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
