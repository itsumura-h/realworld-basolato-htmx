import std/asyncdispatch
import allographer/query_builder
import allographer/schema_builder


proc createTable*(rdb:PostgresConnections) {.async.} =
  rdb.create(
    table("user",
      Column.increments("id"),
      Column.string("username"),
      Column.string("email").unique(),
      Column.datetime("email_verified_at").nullable(),
      Column.string("password"),
      Column.text("bio").nullable(),
      Column.text("image").nullable(),
      Column.timestamps(),
    ),
    table("article",
      Column.string("title"),
      Column.string("slug").unique(), # id
      COlumn.text("description"),
      COlumn.text("body"),
      Column.foreign("author_id").reference("id").onTable("user").onDelete(CASCADE),
      Column.timestamps()
    ),
    table("comment",
      Column.increments("id"),
      COlumn.text("body"),
      Column.strForeign("article_slug").reference("slug").onTable("article").onDelete(CASCADE),
      Column.foreign("author_id").reference("id").onTable("user").onDelete(CASCADE),
      Column.timestamps()
    ),
    table("tag",
      Column.string("tag_name").unique(),
    ),

    table("follow_user_user_map",
      Column.foreign("user_id").reference("id").onTable("user").onDelete(CASCADE),
      Column.foreign("follower_id").reference("id").onTable("user").onDelete(CASCADE),
    ),
    table("favorite_user_article_map",
      Column.foreign("user_id").reference("id").onTable("user").onDelete(CASCADE),
      Column.strForeign("article_id").reference("slug").onTable("article").onDelete(CASCADE),
    ),
    table("tag_list_tag_article_map",
      Column.strForeign("tag_name").reference("tag_name").onTable("tag").onDelete(CASCADE),
      Column.strForeign("article_id").reference("slug").onTable("article").onDelete(CASCADE),
    )
  )
