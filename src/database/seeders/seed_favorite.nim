import std/asyncdispatch
import std/json
import std/strutils
import allographer/query_builder
import faker


proc favorite*(rdb:PostgresConnections) {.async.} =
  let articles = rdb.table("article").get().await
  let articleCount = articles.len()
  var favorites:seq[JsonNode]
  for i in 1..200:
    while true:
      let userId = rand(1..20)
      let randomArticleNum = rand(0..articleCount-1)
      let articleId = articles[randomArticleNum]["slug"].getStr()

      var hasSame = false
      for favorite in favorites:
        if favorite["user_id"].getInt() == userId and favorite["article_id"].getStr() == articleId:
          hasSame = true
          break

      if hasSame:
        continue

      favorites.add(%*{
        "user_id": userId,
        "article_id": articleId,
      })
      break
  
  rdb.table("favorite_user_article_map").insert(favorites).await
