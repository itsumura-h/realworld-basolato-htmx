import std/asyncdispatch
import std/json
import std/strutils
import std/random
import allographer/query_builder


proc userUserMap*(rdb:PostgresConnections) {.async.} =
  let users = rdb.table("user").get().await

  var data:seq[JsonNode]
  for user in users:
    let followerCount = rand(0..users.len)
    for _ in 0..followerCount:
      while true:
        let follower = users[rand(0..<users.len)]
        if follower["id"].getStr() == user["id"].getStr():
          continue
        data.add(%*{"user_id": user["id"].getStr(), "follower_id": follower["id"].getStr()})
        break

  rdb.table("user_user_map").insert(data).await
