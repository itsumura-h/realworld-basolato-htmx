import std/asyncdispatch
import std/json
import allographer/query_builder
from ../../../config/database import rdb
import ../../usecases/article/article_query_interface


type ArticleQuery* = ref object

proc new*(_:type ArticleQuery):ArticleQuery =
  return ArticleQuery()


proc getGlobalFeed(self:ArticleQuery, page=1):Future[seq[JsonNode]] {.async.} =
  let display = 5
  let offset = (page - 1) * display
  let articles = rdb.select(
                  "article.slug",
                  "article.title",
                  "article.description",
                  "article.created_at",
                  "user.id as user_id",
                  "user.username",
                )
                .table("article")
                .join("user", "user.id", "=", "article.author_id")
                .offset(offset)
                .limit(display)
                .get()
                .await

  for i in 0..articles.len-1:
    let article = articles[i]
    let count = rdb.table("favorite_user_article_map")
                  .where("article_id", "=", article["slug"].getStr())
                  .count()
                  .await
    articles[i]["count"] = %count
  
  echo articles[0].pretty()
  return articles


proc toInterface*(self:ArticleQuery):IArticleQuery =
  return (
    getGlobalFeed:proc():Future[seq[JsonNode]] = self.getGlobalFeed(),
  )
