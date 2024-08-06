import std/asyncdispatch
import std/json
import allographer/query_builder
from ../../../../../config/database import rdb
import ../../../../models/dto/article/article_list_query_interface
import ../../../../models/dto/article/article_dto


type GlobalFeedArticleListQuery* = object of IGlobalFeedArticleListQuery

proc new*(_:type GlobalFeedArticleListQuery):GlobalFeedArticleListQuery =
  return GlobalFeedArticleListQuery()


method invoke*(
  self:GlobalFeedArticleListQuery,
  offset:int,
  display:int,
  isLogin:bool,
  loginUserId:string
):Future[seq[ArticleDto]] {.async.} =
  let articleListJson = rdb.select(
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

  var articleList:seq[ArticleDto]
  for i, row in articleListJson:
    let articleId = row["id"].getStr()
    let popularCount = rdb.table("user_article_map")
                          .where("article_id", "=", articleId)
                          .count()
                          .await

    let isLoginUserLikedCount = rdb.table("user_article_map")
                          .where("article_id", "=", articleId)
                          .where("user_id", "=", loginUserId)
                          .count()
                          .await
    let isLoginUserLiked = isLoginUserLikedCount > 0

    let author = AuthorDto.new(
      id = row["author_id"].getStr(),
      name = row["name"].getStr(),
      image = row["image"].getStr(),
    )

    let articleTagCount = rdb.table("tag_article_map")
                              .where("article_id", "=", articleId)
                              .count()
                              .await

    let tagList =
      if articleTagCount > 0:
        rdb.select(
              "tag.id",
              "tag.name",
            )
            .table("tag")
            .join("tag_article_map", "tag_article_map.tag_id", "=", "tag.id")
            .where("tag_article_map.article_id", "=", articleId)
            .get()
            .orm(TagDto)
            .await
      else:
        newSeq[TagDto]()

    let article = ArticleDto.new(
      id = row["id"].getStr(),
      title = row["title"].getStr(),
      description = row["description"].getStr(),
      createdAt = row["createdAt"].getStr(),
      popularCount = popularCount,
      isLoginUserLiked = isLoginUserLiked,
      author = author,
      tagList = tagList,
    )

    articleList.add(article)

  return articleList
