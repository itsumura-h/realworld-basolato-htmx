import std/asyncdispatch
import std/json
import std/times
import std/strutils
import basolato/password
import allographer/query_builder
import faker
import ./lib/random_text


let fake = newFaker()

proc article*(rdb:PostgresConnections) {.async.} =
  let users = rdb.table("user").get().await
  var articles:seq[JsonNode]
  for i in 1..30:
    let title = randomText(5)
    let id = title.replace(" ", "-")
    articles.add(%*{
      "title": title,
      "id": id,
      "description": randomText(30),
      "body": randomText(1000),
      "author_id": users[rand(0..<users.len)]["id"].getStr(),
      "created_at": now().utc().format("yyyy-MM-dd hh:mm:ss")
    })
  
  rdb.table("article").insert(articles).await
