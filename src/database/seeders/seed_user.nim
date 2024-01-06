import std/asyncdispatch
import std/json
import std/times
import basolato/password
import allographer/query_builder
import faker
import ./lib/random_text


let fake = newFaker()

proc user*(rdb:PostgresConnections) {.async.} =
  var users:seq[JsonNode]
  for i in 1..20:
    let name = fake.name()
    users.add(%*{
      "username": fake.name(),
      "email": fake.email(),
      "password": genHashedPassword("password"),
      "bio": randomText(100),
      "created_at": now().utc().format("yyyy-MM-dd hh:mm:ss")
    })
  
  rdb.table("user").insert(users).await
