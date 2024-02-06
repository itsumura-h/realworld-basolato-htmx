import std/asyncdispatch
import std/json
import allographer/query_builder
import ../../../usecases/get_tag_feed/get_tag_feed_query_interface
import ../../../usecases/get_tag_feed/get_tag_feed_dto
import ../../../models/aggregates/article/vo/tag_name
from ../../../../config/database import rdb


type GetTagFeedQuery* = object of IGetTagFeedQuery

proc new*(_:type GetTagFeedQuery):GetTagFeedQuery =
  return GetTagFeedQuery()


method invoke*(self:GetTagFeedQuery, tagName:TagName, page:int):Future[TagFeedDto] {.async.} =
  let total = rdb.table("tag_article_map")
                  .join("tag", "tag.id", "=", "tag_article_map.tag_id")
                  .where("tag.tag_name", "=", tagName.value)
                  .count()
                  .await
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
                        .join("tag_article_map", "tag_article_map.article_id", "=", "article.id")
                        .join("tag", "tag.id", "=", "tag_article_map.tag_id")
                        .join("user", "user.id", "=", "article.author_id")
                        .where("tag.tag_name", "=", tagName.value)
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

    let author = AuthorDto.new(
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
              "tag_article_map.tag_id as id",
              "tag.tag_name as name",
            )
            .table("tag_article_map")
            .join("tag", "tag.id", "=", "tag_article_map.tag_id")
            .where("tag_article_map.article_id", "=", articleId)
            .get(TagDto)
            .await
      else:
        newSeq[TagDto]()

    let article = ArticleWithAuthorDto.new(
      id = row["id"].getStr(),
      title = row["title"].getStr(),
      description = row["description"].getStr(),
      createdAt = row["createdAt"].getStr(),
      popularCount = popularCount,
      author = author,
      tags = tags
    )

    articles.add(article)

  let paginator = PaginatorDto.new(
    hasPages=hasPages,
    current=page,
    lastPage=lastPage
  )

  let viewModel = TagFeedDto.new(
    articles,
    paginator,
  )
  return viewModel
