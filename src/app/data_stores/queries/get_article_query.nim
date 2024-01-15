import std/asyncdispatch
import std/json
import std/options
import allographer/query_builder
import basolato/core/base
from ../../../config/database import rdb
import ../../http/views/pages/article/htmx_article_show_view_model



type GetArticleQuery* = object

proc new*(_:type GetArticleQuery):GetArticleQuery =
  return GetArticleQuery()


proc invoke*(self:GetArticleQuery, articleId:string):Future[HtmxArticleShowViewModel] {.async.} =
  let resOpt = rdb.select(
                "title",
                "description",
                "body",
                "article.created_at as createdAt",
                "author_id as authorId",
                "user.name",
                "user.username as userName",
                "user.image",
              )
              .table("article")
              .join("user", "user.id", "=", "article.author_id")
              .find(articleId, key="article.id")
              .await
  if not resOpt.isSome():
    raise newException(Error404, "invalid article id")
  let res = resOpt.get()

  let articleTagCount = rdb.table("tag_article_map")
                            .where("article_id", "=", articleId)
                            .count()
                            .await

  let tags =
    if articleTagCount > 0:
      rdb.select(
            "tag_article_map.tag_id as tagId",
            "tag_article_map.article_id as articleId",
            "tag.tag_name as tagName",
          )
          .table("tag_article_map")
          .join("tag", "tag.id", "=", "tag_article_map.tag_id")
          .where("tag_article_map.article_id", "=", articleId)
          .get(Tag)
          .await
    else:
      newSeq[Tag]()

  let article = Article.new(
    id = articleId,
    title = res["title"].getStr(),
    description = res["description"].getStr(),
    body = res["body"].getStr(),
    createdAt = res["createdAt"].getStr(),
    tags = tags,
  )


  let user = User.new(
    id = res["authorId"].getInt(),
    name = res["name"].getStr(),
    username = res["userName"].getStr(),
    image = res["image"].getStr()
  )

  let viewModel = HtmxArticleShowViewModel.new(
    article = article,
    user = user
  )
  return viewModel
