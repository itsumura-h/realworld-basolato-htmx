import std/asyncdispatch
import std/times
import ../../../models/aggregates/user/vo/user_id
import ../../../usecases/get_favorites_in_user/get_favorites_in_user_query_interface
import ../../../usecases/get_favorites_in_user/get_favorites_in_user_dto


type MockGetFavoritesInUserQuery*  = object of IGetFavoritesInUserQuery

proc init*(_:type MockGetFavoritesInUserQuery):MockGetFavoritesInUserQuery =
  return MockGetFavoritesInUserQuery()


method invoke*(self:MockGetFavoritesInUserQuery, userId:UserId):Future[GetFavoritesInUserDto] {.async.} =
  let user = UserDto.init("user-1")
  
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

  let dto = GetFavoritesInUserDto.init(
    user,
    articles
  )
  return dto
