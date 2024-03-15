import std/asyncdispatch
import std/json
import std/times
import std/strutils
import basolato/password
import allographer/query_builder
import faker
import ./lib/random_text
import ../../app/models/vo/article_id
import ../../app/models/vo/title


let fake = newFaker()

proc article*(rdb:PostgresConnections) {.async.} =
  let users = rdb.table("user").get().await
  var articles:seq[JsonNode]
  for i in 1..30:
    let title = Title.new( randomText(5) )
    let id = ArticleId.new(title)
    articles.add(%*{
      "title": title.value,
      "id": id.value,
      "description": randomText(30),
      "body": randomText(1000),
      "author_id": users[rand(0..<users.len)]["id"].getStr(),
      "created_at": now().utc().format("yyyy-MM-dd hh:mm:ss")
    })
  
  rdb.table("article").insert(articles).await
