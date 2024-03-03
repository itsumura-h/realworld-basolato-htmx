import std/asyncdispatch
import ../../../usecases/get_tag_feed/get_tag_feed_query_interface
import ../../../usecases/get_tag_feed/get_tag_feed_dto
import ../../../models/vo/tag_name


type MockGetTagFeedQuery*  = object of IGetTagFeedQuery

proc new*(_:type MockGetTagFeedQuery):MockGetTagFeedQuery =
  return MockGetTagFeedQuery()


method invoke*(self:MockGetTagFeedQuery, tagName:TagName, page:int):Future[TagFeedDto] {.async.} =
  let tags = @[
    TagDto(id:"tag1", name:"tag1"),
    TagDto(id:"tag2", name:"tag2"),
  ]

  let author1 = AuthorDto.new("author-1", "Author 1", "")
  let author2 = AuthorDto.new("author-2", "Author 2", "")

  let articles = @[
    ArticleWithAuthorDto.new("title-1", "Title 1", "description 1", "2024-01-01 00:00:00", 2, author1, tags),
    ArticleWithAuthorDto.new("title-2", "Title 2", "description 2", "2024-01-01 00:00:00", 2, author2, tags),
  ]

  let pagination = PaginatorDto.new(
    false,
    1,
    1
  )

  let dto = TagFeedDto.new(
    articles,
    pagination
  )
  return dto
