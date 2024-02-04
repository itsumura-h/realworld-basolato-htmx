import std/asyncdispatch
import std/json
import std/times
import std/strutils
import std/strformat
import std/random
import basolato/password
import allographer/query_builder
import faker
import ./lib/random_text


proc generateRandomRGB(): string =
  let r = rand(255).toHex()[^2..^1]
  let g = rand(255).toHex()[^2..^1]
  let b = rand(255).toHex()[^2..^1]
  return r & g & b


proc user*(rdb:PostgresConnections) {.async.} =
  let fake = newFaker()

  var users:seq[JsonNode]
  for i in 1..20:
    let name = fake.name()
    let imageName = name.toLowerAscii().multiReplace([(".", ""), (" ", "+")])
    let rpg = generateRandomRGB()
    users.add(%*{
      "id": name.toLowerAscii().multiReplace([(".", ""), (" ", "-")]),
      "name": name,
      "email": fake.email(),
      "password": genHashedPassword("password"),
      "bio": randomText(30),
      "image": &"https://via.placeholder.com/640x480.png/{rpg}?text={imageName}",
      "created_at": now().utc().format("yyyy-MM-dd hh:mm:ss")
    })
  
  rdb.table("user").insert(users).await
