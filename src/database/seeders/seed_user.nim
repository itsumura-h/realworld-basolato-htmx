import std/asyncdispatch
import std/json
import std/times
import std/strutils
import basolato/password
import allographer/query_builder
import faker
import ./lib/random_text



proc user*(rdb:PostgresConnections) {.async.} =
  let fake = newFaker()

  var users:seq[JsonNode]
  for i in 1..20:
    let name = fake.name()
    users.add(%*{
      "id": name.toLowerAscii().multiReplace([(".", ""), (" ", "-")]),
      "name": name,
      "email": fake.email(),
      "password": genHashedPassword("password"),
      "bio": randomText(30),
      "created_at": now().utc().format("yyyy-MM-dd hh:mm:ss")
    })
  
  rdb.table("user").insert(users).await
