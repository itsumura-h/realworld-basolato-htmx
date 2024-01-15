import std/asyncdispatch
import std/options
import ../../../../di_container
import ../../../value_objects/email
import ./creating_user_repository_interface


type CreatingUserService* = object
  repository: ICreatingUserRepository

proc new*(_:type CreatingUserService):CreatingUserService =
  return CreatingUserService(
    repository: di.userRepository
  )

proc isEmailUnique*(self:CreatingUserService, email:Email):Future[bool] {.async.} =
  let user = self.repository.getUserByEmail(email).await
  return not user.isSome()
