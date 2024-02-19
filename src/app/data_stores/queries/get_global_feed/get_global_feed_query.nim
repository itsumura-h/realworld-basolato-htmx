import std/asyncdispatch
import std/json
import allographer/query_builder
from ../../../../config/database import rdb
import ../../../usecases/get_global_feed/get_global_feed_dto


type GetGlobalFeedQuery*  = object

proc init*(_:type GetGlobalFeedQuery):GetGlobalFeedQuery =
  return GetGlobalFeedQuery()


proc invoke*(self:GetGlobalFeedQuery, page:int):Future[GlobalFeedDto] {.async.} =
  let total = rdb.table("article").count().await
  const display = 5
  let offset = (page - 1) * display
  let lastPage = total div display
  let hasPages = lastPage > 1
  let articlesJson = rdb.select(
                      "article.id",
                      "article.title",
                      "article.description",
                      "article.created_at as createdAt",
                      "user.id as userId",
                      "user.name",
                      "user.image as image",
                    )
                    .table("article")
                    .join("user", "user.id", "=", "article.author_id")
                    .offset(offset)
                    .limit(display)
                    .get()
                    .await

  var articles:seq[ArticleWithAuthorDto]
  for i, row in articlesJson:
    let articleId = row["id"].getStr()
    let popularCount = rdb.table("user_article_map")
                          .where("article_id", "=", articleId)
                          .count()
                          .await

    let author = AuthorDto.init(
      id = row["userId"].getStr(),
      name = row["name"].getStr(),
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
              "tag.name as tagName",
            )
            .table("tag_article_map")
            .join("tag", "tag.id", "=", "tag_article_map.tag_id")
            .where("tag_article_map.article_id", "=", articleId)
            .get(TagDto)
            .await
      else:
        newSeq[TagDto]()

    let article = ArticleWithAuthorDto.init(
      id = row["id"].getStr(),
      title = row["title"].getStr(),
      description = row["description"].getStr(),
      createdAt = row["createdAt"].getStr(),
      popularCount = popularCount,
      author = author,
      tags = tags
    )

    articles.add(article)

  let paginator = PaginatorDto.init(
    hasPages=hasPages,
    current=page,
    lastPage=lastPage
  )

  let viewModel = GlobalFeedDto.init(
    articles,
    paginator,
  )
  return viewModel
