import std/asyncdispatch
import std/options
import std/json
import std/times
import allographer/query_builder
from ../../../../config/database import rdb
import ../../../models/vo/user_id
import ../../../models/vo/user_name
import ../../../models/vo/email
import ../../../models/vo/password
import ../../../models/vo/hashed_password
import ../../../models/vo/bio
import ../../../models/vo/image
import ../../../models/aggregates/user/user_entity
import ../../../models/aggregates/user/user_repository_interface


type UserRepository*  = object of IUserRepository

proc new*(_:type UserRepository):UserRepository =
  return UserRepository()


method getUserByEmail(self:UserRepository, email:Email):Future[Option[User]] {.async.} =
  let rowOpt =
    rdb.table("user")
    .where("email", "=", email.value)
    .first()
    .await

  if not rowOpt.isSome():
    return none(User)

  let row = rowOpt.get()
  let user = User.new(
    UserId.new(row["id"].getStr),
    UserName.new(row["name"].getStr),
    Email.new(row["email"].getStr),
    HashedPassword.new(row["password"].getStr),
    Bio.new(row["bio"].getStr),
    Image.new(row["image"].getStr),
  )
  return user.some()


method getUserById*(self:UserRepository, userId:UserId):Future[Option[User]] {.async.} =
  let rowOpt =
    rdb.table("user")
    .where("id", "=", userId.value)
    .first()
    .await
  
  if not rowOpt.isSome():
    return none(User)

  let row = rowOpt.get()
  let user = User.new(
    UserId.new(row["id"].getStr),
    UserName.new(row["name"].getStr),
    Email.new(row["email"].getStr),
    HashedPassword.new(row["password"].getStr),
    Bio.new(row["bio"].getStr),
    Image.new(row["image"].getStr),
  )
  return user.some()


method create*(self:UserRepository, user:DraftUser) {.async.} =
  rdb.table("user").insert(%*{
    "id":user.id.value,
    "name":user.name.value,
    "email":user.email.value,
    "password":user.password.value,
    "created_at": user.createdAt.format("yyyy-MM-dd hh:mm:ss"),
  }).await


method update*(self:UserRepository, user:User) {.async.} =
  let val = %*{
    "name": user.name.value,
    "email": user.email.value,
    "bio": user.bio.value,
    "image": user.image.value,
  }
  if user.password.value != "":
    val["password"] = %user.password.value

  rdb.table("user")
  .where("id", "=", user.id.value)
  .update(val)
  .await
