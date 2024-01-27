import std/asyncdispatch
import std/json
import std/options
import std/times
import allographer/query_builder
from ../../../../config/database import rdb
import ../../../usecases/get_comments_in_article/get_comments_in_article_dto
import ../../../usecases/get_comments_in_article/get_comments_in_article_query_interface


type GetCommentsInArticleQuery* = object of IGetCommentsInArticleQuery

proc new*(_:type GetCommentsInArticleQuery):GetCommentsInArticleQuery =
  return GetCommentsInArticleQuery()


method invoke*(self:GetCommentsInArticleQuery, articleId:string):Future[GetCommentsInArticleDto] {.async.} =
  let articleData = rdb.select(
                        "article.id",
                        "article.author_id",
                        "user.name",
                        "user.username",
                        "user.image",
                      )
                      .table("article")
                      .join("user", "user.id", "=", "author_id")
                      .find(articleId, "article.id")
                      .await
                      .get()
  let author = UserDto.new(
    articleData["name"].getStr,
    articleData["username"].getStr,
    articleData["image"].getStr,
  )
  let article = ArticleDto.new(
    articleData["id"].getStr,
    author
  )

  let commentsData = rdb.select(
                      "comment.article_id",
                      "comment.body",
                      "comment.created_at",
                      "user.name",
                      "user.username",
                      "user.image",
                    )
                    .table("comment")
                    .where("article_id", "=", articleId)
                    .join("user", "user.id", "=", "comment.author_id")
                    .get()
                    .await
  
  var comments:seq[CommentDto]
  for commentData in commentsData:
    let user = UserDto.new(
      commentData["name"].getStr,
      commentData["username"].getStr,
      commentData["image"].getStr,
    )
    comments.add(
      CommentDto.new(
        user,
        commentData["body"].getStr,
        commentData["created_at"].getStr().parse("yyyy-MM-dd hh:mm:ss")
      )
    )

  let dto = GetCommentsInArticleDto.new(
    comments,
    article
  )
  return dto
