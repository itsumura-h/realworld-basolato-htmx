import std/asyncdispatch
import allographer/query_builder
import allographer/schema_builder


proc user*(rdb:SqliteConnections) {.async.} =
  echo "rdb: ",$rdb
  rdb.create(
    table("user",
      Column.increments("id"),
      Column.string("username"),
      Column.string("email").unique(),
      Column.string("password"),
      Column.text("bio").nullable(),
      Column.text("image").nullable(),
      Column.timestamps(),
    )
  )
