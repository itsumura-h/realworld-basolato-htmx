import std/asyncdispatch
import std/json
import allographer/query_builder
from ../../../config/database import rdb
import ../../http/views/pages/home/htmx_global_feed_view_model


type GetGlobalFeedQuery* = object

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
    let articleId = row["id"].getStr()
    let popularTagsCount = rdb.table("user_article_map")
                          .where("article_id", "=", articleId)
                          .count()
                          .await

    let user = User.new(
      id = row["userId"].getInt(),
      name = row["userName"].getStr(),
      image = row["image"].getStr(),
    )

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
      id = row["id"].getStr(),
      title = row["title"].getStr(),
      description = row["description"].getStr(),
      createdAt = row["createdAt"].getStr(),
      popularTagsCount = popularTagsCount,
      user = user,
      tags = tags
    )

    articles.add(article)

  let paginator = Paginator.new(
    hasPages=hasPages,
    current=page,
    lastPage=lastPage
  )

  let viewModel = HtmxGlobalFeedViewModel.new(
    articles=articles,
    paginator=paginator
  )
  return viewModel
