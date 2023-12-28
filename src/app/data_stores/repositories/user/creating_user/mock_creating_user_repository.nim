import std/asyncdispatch
import interface_implements
import allographer/query_builder
from ../../../../../config/database import rdb
import ../../../../models/value_objects/user_name
import ../../../../models/aggregates/user/creating_user/creating_user_entity
import ../../../../models/aggregates/user/creating_user/creating_user_repository_interface


type MockCreatingUserRepository* = ref object

proc new*(_:type MockCreatingUserRepository):CreatingUserRepository =
  return MockCreatingUserRepository()

implements MockCreatingUserRepository, ICreatingUserRepository:
  discard
