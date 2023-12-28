import std/asyncdispatch
import ../../errors
import ../../di_container
import ../../models/aggregates/user/creating_user/creating_user_repository_interface
import ../../models/aggregates/user/creating_user/creating_user_service
import ../../models/aggregates/user/creating_user/creating_user_entity
import ../../models/value_objects/user_name
import ../../models/value_objects/email
import ../../models/value_objects/password

type CreateUserUsecase* = ref object
  repository:ICreatingUserRepository

proc new(_:type CreateUserUsecase):CreateUserUsecase =
  return CreateUserUsecase(
    repository:di.userRepository
  )

proc invoke*(self:CreateUserUsecase, userName, email, password:string){.async.} =
  let userName = UserName.new(userName)
  let email = Email.new(email)
  let password = Password.new(password)

  let service = CreatingUserService.new()
  if not service.isEmailUnique(email).await:
    raise newException(DomainError, "email is deprecated")

  let user = CreatingUser.new(userName, email, password)
