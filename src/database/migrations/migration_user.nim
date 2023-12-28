import std/asyncdispatch
import std/json
import allographer/schema_builder
from ../../config/database import rdb


proc user*() {.async.} =
  rdb.create(
    table("user",
      Column.increments("id"),
      Column.string("username"),
      Column.string("email").unique(),
      Column.string("password"),
      Column.text("bio").nullable(),
      Column.text("image").nullable(),
    )
  )
