import std/asyncdispatch
from ../../config/database import rdb
import ./seed_user
import ./seed_article


proc main() =
  user(rdb).waitFor()
  article(rdb).waitFor()


main()
