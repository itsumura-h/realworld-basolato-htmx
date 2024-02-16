import std/asyncdispatch
import ../../../usecases/get_tag_feed/get_tag_feed_query_interface
import ../../../usecases/get_tag_feed/get_tag_feed_dto
import ../../../models/aggregates/article/vo/tag_name


type MockGetTagFeedQuery* = object of IGetTagFeedQuery

proc init*(_:type MockGetTagFeedQuery):MockGetTagFeedQuery =
  return MockGetTagFeedQuery()


method invoke*(self:MockGetTagFeedQuery, tagName:TagName, page:int):Future[TagFeedDto] {.async.} =
  let tags = @[
    TagDto(id:1, name:"tag1"),
    TagDto(id:2, name:"tag2"),
  ]

  let author1 = AuthorDto.init("author-1", "Author 1", "")
  let author2 = AuthorDto.init("author-2", "Author 2", "")

  let articles = @[
    ArticleWithAuthorDto.init("title-1", "Title 1", "description 1", "2024-01-01 00:00:00", 2, author1, tags),
    ArticleWithAuthorDto.init("title-2", "Title 2", "description 2", "2024-01-01 00:00:00", 2, author2, tags),
  ]

  let pagination = PaginatorDto.init(
    false,
    1,
    1
  )

  let dto = TagFeedDto.init(
    articles,
    pagination
  )
  return dto
