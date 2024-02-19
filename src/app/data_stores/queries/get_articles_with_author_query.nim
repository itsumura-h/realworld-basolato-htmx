import std/asyncdispatch
import std/json
import allographer/query_builder
from ../../../config/database import rdb
import ../../usecases/get_global_feed/get_global_feed_dto


type GetArticlesWithAuthorQuery*  = object

proc init*(_:type GetArticlesWithAuthorQuery):GetArticlesWithAuthorQuery =
  return GetArticlesWithAuthorQuery()


proc invoke*(self:GetArticlesWithAuthorQuery, page=1):Future[seq[ArticleWithAuthorDto]] {.async.} =
  const display = 5
  let offset = (page - 1) * display
  let articlesJson = rdb.select(
                      "article.id",
                      "article.title",
                      "article.description",
                      "article.created_at as createdAt",
                      "article.author_id",
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
      id = row["author_id"].getStr(),
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
              "tag.name",
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

  return articles
