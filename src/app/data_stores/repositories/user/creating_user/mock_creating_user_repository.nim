import std/asyncdispatch
import std/options
import std/json
import std/times
import interface_implements
import allographer/query_builder
from ../../../../../config/database import testRdb
import ../../../../models/value_objects/user_name
import ../../../../models/value_objects/email
import ../../../../models/value_objects/password
import ../../../../models/aggregates/user/creating_user/creating_user_entity
import ../../../../models/aggregates/user/creating_user/creating_user_repository_interface

let rdb = testRdb

type MockCreatingUserRepository* = ref object

proc new*(_:type MockCreatingUserRepository):MockCreatingUserRepository =
  return MockCreatingUserRepository()


proc getUserByEmail(self:MockCreatingUserRepository, email:Email):Future[Option[JsonNode]] {.async.} =
  return rdb.table("user")
            .where("email", "=", email.value())
            .first()
            .await


proc create(self:MockCreatingUserRepository, user:CreatingUser):Future[void] {.async.} =
  rdb.table("user").insert(%*{
    "username":user.userName().value(),
    "email":user.email().value(),
    "password":user.password().hashed(),
    "created_at": now().utc().format("yyyy-MM-dd hh:mm:ss"),
  }).await


proc toInterface*(self:MockCreatingUserRepository):ICreatingUserRepository =
  return (
    getUserByEmail:proc(email:Email):Future[Option[JsonNode]] = self.getUserByEmail(email),
    create:proc(user:CreatingUser):Future[void] = self.create(user),
  )

# implements CreatingUserRepository, ICreatingUserRepository:
