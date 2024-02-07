import std/asyncdispatch
import std/json
import std/options
import std/times
import std/sequtils
import std/strformat
import allographer/query_builder
from ../../../../config/database import rdb
import ../../../errors
import ../../../usecases/get_comments_in_article/get_comments_in_article_dto
import ../../../usecases/get_comments_in_article/get_comments_in_article_query_interface


type GetCommentsInArticleQuery* = object of IGetCommentsInArticleQuery

proc new*(_:type GetCommentsInArticleQuery):GetCommentsInArticleQuery =
  return GetCommentsInArticleQuery()


method invoke*(self:GetCommentsInArticleQuery, articleId:string):Future[GetCommentsInArticleDto] {.async.} =
  let articleDataOpt = rdb.select(
                        "article.id",
                        "article.author_id",
                        "user.name",
                        "user.image",
                      )
                      .table("article")
                      .join("user", "user.id", "=", "author_id")
                      .find(articleId, "article.id")
                      .await
  
  let articleData =
    if articleDataOpt.isSome():
      articleDataOpt.get()
    else:
      raise newException(IdNotFoundError, &"articleId {articleId} is not found")

  let author = UserDto.new(
    articleData["author_id"].getStr,
    articleData["name"].getStr,
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
                      "user.id as userId",
                      "user.name",
                      "user.image",
                    )
                    .table("comment")
                    .where("article_id", "=", articleId)
                    .join("user", "user.id", "=", "comment.author_id")
                    .get()
                    .await
  
  let comments = commentsData.map(
    proc(row:JsonNode):CommentDto =
      let user = UserDto.new(
        row["userId"].getStr,
        row["name"].getStr,
        row["image"].getStr,
      )
      let comment = CommentDto.new(
        user,
        row["body"].getStr,
        row["created_at"].getStr().parse("yyyy-MM-dd hh:mm:ss")
      )
      return comment
  )

  let dto = GetCommentsInArticleDto.new(
    comments,
    article
  )
  return dto
