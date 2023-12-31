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


proc getUserByEmail(self:CreatingUserRepository, email:Email):Future[Option[JsonNode]] {.async.} =
  return rdb.table("user")
            .where("email", "=", email.value())
            .first()
            .await


proc create(self:CreatingUserRepository, user:CreatingUser):Future[void] {.async.} =
  rdb.table("user").insert(%*{
    "username":user.userName().value(),
    "email":user.email().value(),
    "password":user.password().hashed(),
  }).await


proc toInterface*(self:CreatingUserRepository):ICreatingUserRepository =
  return (
    getUserByEmail:proc(email:Email):Future[Option[JsonNode]] = self.getUserByEmail(email),
    create:proc(user:CreatingUser):Future[void] = self.create(user),
  )

# implements CreatingUserRepository, ICreatingUserRepository:
