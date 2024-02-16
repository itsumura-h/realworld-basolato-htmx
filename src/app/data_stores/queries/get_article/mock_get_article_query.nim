import std/asyncdispatch
import std/times
import std/options
import ../../../usecases/get_article/get_article_query_interface
import ../../../usecases/get_article/get_article_dto
import ../../../models/aggregates/article/vo/article_id
import ../../../models/aggregates/user/vo/user_id


type MockGetArticleQuery* = object of IGetArticleQuery

proc init*(_:type MockGetArticleQuery):MockGetArticleQuery =
  return MockGetArticleQuery()


method invoke*(self:MockGetArticleQuery, articleId:ArticleId, loginUserId:Option[UserId]):Future[GetArticleDto] {.async.} =
  let tags = @[
    TagDto.init(
      1,
      articleId.value,
      "tag name 1"
    ),
    TagDto.init(
      2,
      articleId.value,
      "tag name 2"
    ),
  ]

  let article = ArticleDto.init(
    id = articleId.value,
    title = "titie",
    description = "description",
    body = "body",
    createdAt = "2024-01-01 12:00:00",
    tags = tags,
    isFavorited = false,
    favoriteCount = 5,
  )
  let user = UserDto.init(
    "user-name",
    "user name",
    "",
    5
  )
  let dto = GetArticleDto.init(
    article,
    user
  )
  return dto
