import std/asyncdispatch
import std/times
import ../../../models/vo/article_id
import ../../../models/vo/user_id
import ../../../usecases/get_articles_in_user/get_articles_in_user_query_interface
import ../../../usecases/get_articles_in_user/get_articles_in_user_dto
import ../get_favorite_button/mock_get_favorite_button_query


type MockGetArticlesInUserQuery*  = object of IGetArticlesInUserQuery

proc new*(_:type MockGetArticlesInUserQuery):MockGetArticlesInUserQuery =
  return MockGetArticlesInUserQuery()


method invoke*(self:MockGetArticlesInUserQuery, userId:UserId):Future[GetArticlesInUserDto] {.async.} =
  let author = AuthorDto.new(
    "author",
    "Author",
    ""
  )

  let tags = @[
    TagDto.new("tag1"),
    TagDto.new("tag2"),
  ]

  let getFavoriteButtonQuery = MockGetFavoriteButtonQuery.new()
  let articles = @[
    ArticleDto.new(
      "article-1",
      "Article 1",
      "description1",
      "2024-01-01 12:00:00",
      tags,
      getFavoriteButtonQuery.invoke(ArticleId.new("article-1"), userId).await
    ),
    ArticleDto.new(
      "article-2",
      "Article 2",
      "description2",
      "2024-01-01 12:00:00",
      tags,
      getFavoriteButtonQuery.invoke(ArticleId.new("article-2"), userId).await
    ),
  ]

  let dto = GetArticlesInUserDto.new(articles, author)
  return dto
