import std/asyncdispatch
import std/options
import ../../../../di_container
import creating_user_repository_interface
import creating_user_entity
import ../../../value_objects/email


type CreatingUserService* = ref object
  repository: ICreatingUserRepository

proc new*(_:type CreatingUserService):CreatingUserService =
  return CreatingUserService(
    repository: di.userRepository
  )

proc isEmailUnique*(self:CreatingUserService, email:Email):Future[bool] {.async.} =
  let user = self.repository.getUserByEmail(email).await
  return not user.isSome()
