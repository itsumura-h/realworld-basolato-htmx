import std/asyncdispatch
import std/options
import std/json
import std/times
# import interface_implements
import allographer/query_builder
from ../../../../config/database import testRdb
import ../../../models/aggregates/user/vo/user_name
import ../../../models/aggregates/user/vo/email
import ../../../models/aggregates/user/vo/password
import ../../../models/aggregates/user/user_entity
import ../../../models/aggregates/user/user_repository_interface

let rdb = testRdb

type MockUserRepository* = object of IUserRepository

proc new*(_:type MockUserRepository):MockUserRepository =
  return MockUserRepository()


method getUserByEmail*(self:MockUserRepository, email:Email):Future[Option[JsonNode]] {.async.} =
  return rdb.table("user")
            .where("email", "=", email.value())
            .first()
            .await


method create*(self:MockUserRepository, user:DraftUser):Future[void] {.async.} =
  rdb.table("user").insert(%*{
    "id":user.id.value,
    "name":user.name.value,
    "email":user.email.value,
    "password":user.password.hashed(),
    "created_at": now().utc().format("yyyy-MM-dd hh:mm:ss"),
  }).await
