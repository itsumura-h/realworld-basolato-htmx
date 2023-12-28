import std/asyncdispatch
import creating_user_repository_interface
import creating_user_entity
import ../../../value_objects/email


type CreatingUserService* = ref object
  repository: ICreatingUserRepository

proc new*(_:type CreatingUserService, repository:ICreatingUserRepository):CreatingUserService =
  return CreatingUserService(
    repository: repository
  )

proc isEmailUnique*(self:CreatingUserService, email:Email):Future[bool] {.async.} =
  return self.repository.isEmailUnique(email).await
