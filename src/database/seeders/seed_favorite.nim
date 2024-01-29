import std/asyncdispatch
import std/json
import std/strutils
import allographer/query_builder
import faker


proc favorite*(rdb:PostgresConnections) {.async.} =
  let users = rdb.table("user").get().await
  let articles = rdb.table("article").get().await
  let articleCount = articles.len()
  var favorites:seq[JsonNode]
  for i in 1..200:
    while true:
      let userId = users[rand(1..<users.len)]["id"].getStr
      let randomArticleNum = rand(0..articleCount-1)
      let articleId = articles[randomArticleNum]["id"].getStr()

      var hasSame = false
      for favorite in favorites:
        if favorite["user_id"].getStr() == userId and favorite["article_id"].getStr() == articleId:
          hasSame = true
          break

      if hasSame:
        continue

      favorites.add(%*{
        "user_id": userId,
        "article_id": articleId,
      })
      break
  
  rdb.table("user_article_map").insert(favorites).await
