import std/asyncdispatch
import std/json
import std/times
import std/strutils
import basolato/password
import allographer/query_builder
import faker


let fake = newFaker()

type TagArticle = object
  tag:int
  article:string

proc tagArticle*(rdb:PostgresConnections) {.async.} =
  let articles = rdb.select("id").table("article").get().await
  let articleCount = articles.len()

  var tagArticles:seq[TagArticle]
  for i in 1..60:
    while true:
      let tagArticle = TagArticle(
        tag:rand(1..30),
        article: articles[rand(1..articleCount-1)]["id"].getStr()
      )

      if tagArticles.contains(tagArticle):
        continue

      tagArticles.add(tagArticle)
      break

  var jTags:seq[JsonNode]
  for tagArticle in tagArticles:
    jTags.add(%*{"tag_id": tagArticle.tag, "article_id": tagArticle.article})
  
  rdb.table("tag_article_map").insert(jTags).await
