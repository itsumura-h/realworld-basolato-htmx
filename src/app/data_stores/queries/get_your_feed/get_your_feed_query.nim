import std/asyncdispatch
import std/json
import allographer/query_builder
from ../../../../config/database import rdb
import ../../../usecases/get_your_feed/get_your_feed_query_interface
import ../../../usecases/get_your_feed/your_feed_dto
import../../../models/aggregates/user/vo/user_id


type GetYourFeedQuery* = object of IGetYourFeedQuery

proc new*(_:type GetYourFeedQuery):GetYourFeedQuery =
  return GetYourFeedQuery()


method invoke*(self:GetYourFeedQuery, userId:UserId, page:int):Future[YourFeedDto] {.async.} =
  let total = rdb.table("article")
                  .join("user_user_map", "user_user_map.user_id", "=", "article.author_id")
                  .where("user_user_map.follower_id", "=", userId.value)
                  .count()
                  .await
  const display = 5
  let offset = (page - 1) * display
  let lastPage = total div display
  let hasPages = lastPage > 1

  let articlesData = rdb.select(
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
                    .join("user_user_map", "user_user_map.user_id", "=", "article.author_id")
                    .where("user_user_map.follower_id", "=", userId.value)
                    .offset(offset)
                    .limit(display)
                    .get()
                    .await

  var articles:seq[ArticleWithAuthorDto]
  for i, row in articlesData:
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
              "tag.id",
              "tag.name",
            )
            .table("tag")
            .join("tag_article_map", "tag_article_map.tag_id", "=", "tag.id")
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

  let viewModel = YourFeedDto.new(
    articles,
    paginator,
  )
  return viewModel
