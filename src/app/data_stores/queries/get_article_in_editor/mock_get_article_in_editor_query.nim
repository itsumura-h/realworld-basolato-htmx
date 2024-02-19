import std/asyncdispatch
import ../../../usecases/get_article_in_editor/get_article_in_editor_query_interface
import ../../../usecases/get_article_in_editor/get_article_in_editor_dto
import ../../../models/aggregates/article/vo/article_id


type MockGetArticleInEditorQuery* = object of IGetArticleInEditorQuery

proc new*(_:type MockGetArticleInEditorQuery): MockGetArticleInEditorQuery =
  return MockGetArticleInEditorQuery()


method invoke*(self:MockGetArticleInEditorQuery, articleId:ArticleId): Future[ArticleInEditorDto] {.async.} =
  let tags = @[
    Tag.new("tag1"),
    Tag.new("tag2"),
  ]
  
  return ArticleInEditorDto.new(
    "article-id",
    "title",
    "body",
    "description",
    tags,
  )
