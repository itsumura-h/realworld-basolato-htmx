import std/asyncdispatch
import ./migration_user
from ../../../config/database import testRdb


proc main*() =
  user(testRdb).waitFor()

main()
