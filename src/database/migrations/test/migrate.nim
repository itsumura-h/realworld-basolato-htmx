import std/asyncdispatch
from ../../../config/database import testRdb
import ./migration_create_table


proc main*() =
  createTable(testRdb).waitFor()


main()
