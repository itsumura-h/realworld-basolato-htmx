import std/asyncdispatch
import ./migration_user
from ../../../config/database import rdb


proc main*() =
  user(rdb).waitFor()
  
main()
