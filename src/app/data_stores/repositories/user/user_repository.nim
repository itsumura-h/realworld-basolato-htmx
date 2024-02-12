import std/asyncdispatch
import std/options
import std/json
import std/times
import allographer/query_builder
from ../../../../config/database import rdb
import ../../../models/aggregates/user/vo/user_id
import ../../../models/aggregates/user/vo/user_name
import ../../../models/aggregates/user/vo/email
import ../../../models/aggregates/user/vo/password
import ../../../models/aggregates/user/vo/hashed_password
import ../../../models/aggregates/user/vo/bio
import ../../../models/aggregates/user/vo/image
import ../../../models/aggregates/user/user_entity
import ../../../models/aggregates/user/user_repository_interface


type UserRepository* = object of IUserRepository

proc new*(_:type UserRepository):UserRepository =
  return UserRepository()


method getUserByEmail(self:UserRepository, email:Email):Future[Option[User]] {.async.} =
  let rowOpt = rdb.table("user")
                  .where("email", "=", email.value())
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
  let rowOpt = rdb.table("user")
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


method create(self:UserRepository, user:DraftUser):Future[UserId] {.async.} =
  rdb.table("user").insert(%*{
    "id":user.id.value,
    "name":user.name.value,
    "email":user.email.value,
    "password":user.password.hashed(),
    "created_at": now().utc().format("yyyy-MM-dd hh:mm:ss"),
  }).await
  return user.id


method update(self:UserRepository, user:User) {.async.} =
  rdb.table("user")
      .where("id", "=", user.id.value)
      .update(%*{
        "name": user.name.value,
        "email": user.email.value,
        "password": user.password.value,
        "bio": user.bio.value,
        "image": user.image.value,
      })
      .await
