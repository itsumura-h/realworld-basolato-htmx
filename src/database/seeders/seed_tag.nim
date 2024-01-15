import std/asyncdispatch
import std/json
import std/times
import std/strutils
import basolato/password
import allographer/query_builder
import faker


let fake = newFaker()

proc tag*(rdb:PostgresConnections) {.async.} =
  var tags:seq[string]
  for i in 1..30:
    while true:
      let tagName = fake.word()

      if tags.contains(tagName):
        continue

      tags.add(tagName)
      break

  var jTags:seq[JsonNode]
  for tag in tags:
    jTags.add(%*{"tag_name": tag})
  
  rdb.table("tag").insert(jTags).await
