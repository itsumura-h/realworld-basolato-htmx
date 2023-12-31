import std/asyncdispatch
import std/options
import std/json
import creating_user_entity
import ../../../value_objects/email


type ICreatingUserRepository* = tuple
  getUserByEmail:proc(email:Email):Future[Option[JsonNode]]
  create:proc(user:CreatingUser):Future[void]
