import std/asyncdispatch
import std/times
import ../../../models/aggregates/user/vo/user_id
import ../../../usecases/get_articles_in_user/get_articles_in_user_query_interface
import ../../../usecases/get_articles_in_user/get_articles_in_user_dto


type MockGetArticlesInUserQuery* = object of IGetArticlesInUserQuery

proc new*(_:type MockGetArticlesInUserQuery):MockGetArticlesInUserQuery =
  return MockGetArticlesInUserQuery()


method invoke*(self:MockGetArticlesInUserQuery, userId:UserId):Future[GetArticlesInUserQueryDto] {.async.} =
  let author = AuthorDto.new(
    "author",
    "Author",
    ""
  )

  let tags = @[
    TagDto.new("tag1"),
    TagDto.new("tag2"),
  ]

  let favoritedUsers = @[
    FavoritedUserDto.new("user1"),
    FavoritedUserDto.new("user2"),
  ]

  let articles = @[
    ArticleDto.new(
      "article-1",
      "Article 1",
      "description1",
      "2024-01-01 12:00:00",
      author,
      tags,
      favoritedUsers
    ),
    ArticleDto.new(
      "article-2",
      "Article 2",
      "description2",
      "2024-01-01 12:00:00",
      author,
      tags,
      favoritedUsers
    ),
  ]

  let dto = GetArticlesInUserQueryDto.new(articles)
  return dto
