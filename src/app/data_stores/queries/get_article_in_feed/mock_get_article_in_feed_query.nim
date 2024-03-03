import std/asyncdispatch
import std/times
import std/options
import ../../../usecases/get_article_in_feed/get_article_in_feed_query_interface
import ../../../usecases/get_article_in_feed/get_article_in_feed_dto
import ../../../models/vo/article_id
import ../../../models/vo/user_id


type MockGetArticleInFeedQuery*  = object of IGetArticleInFeedQuery

proc new*(_:type MockGetArticleInFeedQuery):MockGetArticleInFeedQuery =
  return MockGetArticleInFeedQuery()


method invoke*(self:MockGetArticleInFeedQuery, articleId:ArticleId, loginUserId:Option[UserId]):Future[GetArticleInFeedDto] {.async.} =
  let tags = @[
    TagDto.new(
      "tag-name-1",
      articleId.value,
      "tag name 1"
    ),
    TagDto.new(
      "tag-name-2",
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
  let dto = GetArticleInFeedDto.new(
    article,
    user
  )
  return dto
