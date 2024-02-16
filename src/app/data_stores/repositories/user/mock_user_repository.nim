import std/asyncdispatch
import std/options
import std/json
import std/times
import allographer/query_builder
from ../../../../config/database import testRdb
import ../../../models/aggregates/user/vo/user_id
import ../../../models/aggregates/user/vo/user_name
import ../../../models/aggregates/user/vo/email
import ../../../models/aggregates/user/vo/password
import ../../../models/aggregates/user/vo/hashed_password
import ../../../models/aggregates/user/vo/bio
import ../../../models/aggregates/user/vo/image
import ../../../models/aggregates/user/user_entity
import ../../../models/aggregates/user/user_repository_interface

let rdb = testRdb

type MockUserRepository* = object of IUserRepository

proc init*(_:type MockUserRepository):MockUserRepository =
  return MockUserRepository()


method getUserByEmail*(self:MockUserRepository, email:Email):Future[Option[User]] {.async.} =
  let rowOpt = rdb.table("user")
                  .where("email", "=", email.value())
                  .first()
                  .await

  if not rowOpt.isSome():
    return none(User)

  let row = rowOpt.get()
  let user = User.init(
    UserId.init(row["id"].getStr),
    UserName.init(row["name"].getStr),
    Email.init(row["email"].getStr),
    HashedPassword.init(row["password"].getStr),
    Bio.init(row["bio"].getStr),
    Image.init(row["image"].getStr),
  )
  return user.some()


method create*(self:MockUserRepository, user:DraftUser):Future[UserId] {.async.} =
  rdb.table("user").insert(%*{
    "id":user.id.value,
    "name":user.name.value,
    "email":user.email.value,
    "password":user.password.hashed(),
    "created_at": now().utc().format("yyyy-MM-dd hh:mm:ss"),
  }).await
  return user.id
