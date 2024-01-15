import std/asyncdispatch
from ../../config/database import rdb
import ./seed_user
import ./seed_article
import ./seed_comment
import ./seed_favorite
import ./seed_tag
import ./seed_tag_article


proc main() =
  user(rdb).waitFor()
  article(rdb).waitFor()
  comment(rdb).waitFor()
  favorite(rdb).waitFor()
  tag(rdb).waitFor()
  tagArticle(rdb).waitFor()


main()
