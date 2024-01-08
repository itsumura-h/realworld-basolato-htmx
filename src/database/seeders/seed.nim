import std/asyncdispatch
from ../../config/database import rdb
import ./seed_user
import ./seed_article
import ./seed_comment
import ./seed_favorite


proc main() =
  user(rdb).waitFor()
  article(rdb).waitFor()
  comment(rdb).waitFor()
  favorite(rdb).waitFor()


main()
