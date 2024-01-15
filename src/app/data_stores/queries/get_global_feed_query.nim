import std/asyncdispatch
import std/json
import std/strformat
import allographer/query_builder
from ../../../config/database import rdb
import ../../http/views/pages/home/htmx_global_feed_view_model


type GetGlobalFeedQuery* = ref object

proc new*(_:type GetGlobalFeedQuery):GetGlobalFeedQuery =
  return GetGlobalFeedQuery()


proc invoke*(self:GetGlobalFeedQuery, page:int):Future[HtmxGlobalFeedViewModel] {.async.} =
  let total = rdb.table("article").count().await
  let display = 5
  let offset = (page - 1) * display
  let lastPage = total div display
  let hasPages = lastPage > 1
  let articlesJson = rdb.select(
                      "article.id",
                      "article.title",
                      "article.description",
                      "article.created_at as createdAt",
                      "user.id as userId",
                      "user.username as userName",
                      "user.image as image",
                    )
                    .table("article")
                    .join("user", "user.id", "=", "article.author_id")
                    .offset(offset)
                    .limit(display)
                    .get()
                    .await

  var articles:seq[Article]
  for i, row in articlesJson:
    let favoriteCount = rdb.table("user_article_map")
                          .where("article_id", "=", row["id"].getStr())
                          .count()
                          .await

    let user = User.new(
      row["userId"].getInt(),
      row["userName"].getStr(),
      row["image"].getStr(),
    )

    let article = Article.new(
      row["id"].getStr(),
      row["title"].getStr(),
      row["description"].getStr(),
      row["createdAt"].getStr(),
      favoriteCount,
      user,
    )

    let articleTagCount = rdb.table("tag_article_map")
                              .where("article_id", "=", article.id)
                              .count()
                              .await

    if articleTagCount > 0:
      let tags = rdb.select(
                      "tag_article_map.tag_id as tagId",
                      "tag_article_map.article_id as articleId",
                      "tag.tag_name as tagName",
                    )
                    .table("tag_article_map")
                    .join("tag", "tag.id", "=", "tag_article_map.tag_id")
                    .where("tag_article_map.article_id", "=", article.id)
                    .get(Tag)
                    .await
      article.tags = tags

    articles.add(article)

  let paginator = Paginator.new(
    hasPages,
    page,
    lastPage
  )

  let viewModel = HtmxGlobalFeedViewModel.new(articles, paginator)
  return viewModel
