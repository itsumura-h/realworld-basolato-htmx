import std/asyncdispatch
import std/options
import std/json
import interface_implements
import allographer/query_builder
from ../../../../../config/database import rdb
import ../../../../models/value_objects/user_name
import ../../../../models/value_objects/email
import ../../../../models/value_objects/password
import ../../../../models/aggregates/user/creating_user/creating_user_entity
import ../../../../models/aggregates/user/creating_user/creating_user_repository_interface


type CreatingUserRepository* = ref object

proc new*(_:type CreatingUserRepository):CreatingUserRepository =
  return CreatingUserRepository()

proc isEmailUnique(self:CreatingUserRepository, email:Email):Future[bool] {.async.} =
  let userOptoon = rdb.table("user").find(email.value()).await
  return userOptoon.isSome()

proc create*(self:CreatingUserRepository, user:CreatingUser):Future[void] {.async.} =
  rdb.table("user").insert(%*{
    "user_name":user.userName().value(),
    "email":user.email().value(),
    "password":user.password().value(),
  }).await

proc toInterface*(self:CreatingUserRepository):ICreatingUserRepository =
  return ICreatingUserRepository(
    isEmailUnique:proc(email:Email):Future[bool] = self.isEmailUnique(email),
    create:proc(user:CreatingUser):Future[void] = self.create(user),
  )

# implements CreatingUserRepository, ICreatingUserRepository:
