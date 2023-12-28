import std/asyncdispatch
import creating_user_entity
import ../../../value_objects/email


type ICreatingUserRepository* = tuple
  isEmailUnique:proc(email:Email):Future[bool]
  create:proc(user:CreatingUser):Future[void]
