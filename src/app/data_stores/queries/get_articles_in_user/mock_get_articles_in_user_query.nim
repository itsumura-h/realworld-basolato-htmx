import std/asyncdispatch
import std/times
import ../../../models/aggregates/user/vo/user_id
import ../../../usecases/get_articles_in_user/get_articles_in_user_query_interface
import ../../../usecases/get_articles_in_user/get_articles_in_user_dto


type MockGetArticlesInUserQuery*  = object of IGetArticlesInUserQuery

proc init*(_:type MockGetArticlesInUserQuery):MockGetArticlesInUserQuery =
  return MockGetArticlesInUserQuery()


method invoke*(self:MockGetArticlesInUserQuery, userId:UserId):Future[GetArticlesInUserDto] {.async.} =
  let author = AuthorDto.init(
    "author",
    "Author",
    ""
  )

  let tags = @[
    TagDto.init("tag1"),
    TagDto.init("tag2"),
  ]

  let favoritedUsers = @[
    FavoritedUserDto.init("user1"),
    FavoritedUserDto.init("user2"),
  ]

  let articles = @[
    ArticleDto.init(
      "article-1",
      "Article 1",
      "description1",
      "2024-01-01 12:00:00",
      author,
      tags,
      favoritedUsers
    ),
    ArticleDto.init(
      "article-2",
      "Article 2",
      "description2",
      "2024-01-01 12:00:00",
      author,
      tags,
      favoritedUsers
    ),
  ]

  let dto = GetArticlesInUserDto.init(articles)
  return dto
