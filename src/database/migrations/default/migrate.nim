import std/asyncdispatch
from ../../../config/database import rdb
import ./migration_create_table


proc main*() =
  createTable(rdb).waitFor()


main()
