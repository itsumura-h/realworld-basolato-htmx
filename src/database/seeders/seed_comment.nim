import std/asyncdispatch
import std/json
import std/times
import std/strutils
import allographer/query_builder
import faker
import ./lib/random_text


proc comment*(rdb:PostgresConnections) {.async.} =
  let users = rdb.table("user").get().await
  let articles = rdb.table("article").get().await
  let articleCount = articles.len()
  var comments:seq[JsonNode]
  for i in 1..60:
    let randomArticleNum = rand(0..articleCount-1)
    comments.add(%*{
      "body": randomText(150),
      "article_id": articles[randomArticleNum]["id"].getStr(),
      "author_id": users[rand(0..<users.len)]["id"].getStr(),
      "created_at": now().utc().format("yyyy-MM-dd hh:mm:ss")
    })
  
  rdb.table("comment").insert(comments).await
