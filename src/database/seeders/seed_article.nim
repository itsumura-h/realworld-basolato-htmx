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
  var articles:seq[JsonNode]
  for i in 1..20:
    let title = randomText(5)
    let slug = title.replace(" ", "_")
    let name = fake.name()
    articles.add(%*{
      "title": title,
      "slug": slug,
      "description": randomText(30),
      "body": randomText(1000),
      "author_id": rand(1..20),
      "created_at": now().utc().format("yyyy-MM-dd hh:mm:ss")
    })
  
  rdb.table("article").insert(articles).await
