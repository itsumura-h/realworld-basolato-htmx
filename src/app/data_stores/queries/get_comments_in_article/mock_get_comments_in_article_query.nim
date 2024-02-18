import std/asyncdispatch
import std/times
import ../../../usecases/get_comments_in_article/get_comments_in_article_dto
import ../../../usecases/get_comments_in_article/get_comments_in_article_query_interface


type MockGetCommentsInArticleQuery*  = object of IGetCommentsInArticleQuery

proc init*(_:type MockGetCommentsInArticleQuery):MockGetCommentsInArticleQuery =
  return MockGetCommentsInArticleQuery()

method invoke(self:MockGetCommentsInArticleQuery, articleId:string):Future[GetCommentsInArticleDto] {.async.} =
  let author = UserDto.init(
    id="author",
    name="author",
    image=""
  )
  let article = ArticleDto.init(
    id="article",
    user=author
  )
  let commentWriter1 = UserDto.init(
    id="comment-writer-1",
    name="comment writer 1",
    image=""
  )
  let comment1 = CommentDto.init(
    user=commentWriter1,
    body="comment 1",
    createdAt=parse("2024-01-01 12:00:00", "yyyy-MM-dd hh:mm:ss")
  )
  let commentWriter2 = UserDto.init(
    id="comment-writer-2",
    name="comment writer 2",
    image=""
  )
  let comment2 = CommentDto.init(
    user=commentWriter2,
    body="comment 2",
    createdAt=parse("2024-01-01 12:00:00", "yyyy-MM-dd hh:mm:ss")
  )
  return GetCommentsInArticleDto.init(
    comments= @[comment1, comment2],
    article= article
  )
