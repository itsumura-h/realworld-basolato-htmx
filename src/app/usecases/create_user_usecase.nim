import std/asyncdispatch
import ../errors
import ../di_container
import ../models/aggregates/user/user_repository_interface
import ../models/aggregates/user/user_service
import ../models/aggregates/user/user_entity
import ../models/aggregates/user/vo/user_name
import ../models/aggregates/user/vo/email
import ../models/aggregates/user/vo/password

type CreateUserUsecase* = object
  repository:IUserRepository

proc new*(_:type CreateUserUsecase):CreateUserUsecase =
  return CreateUserUsecase(
    repository:di.userRepository
  )

proc invoke*(self:CreateUserUsecase, userName, email, password:string){.async.} =
  let userName = UserName.new(userName)
  let email = Email.new(email)
  let password = Password.new(password)

  let service = UserService.new()
  if not service.isEmailUnique(email).await:
    raise newException(DomainError, "email is deprecated")

  let user = User.new(userName, email, password)
  self.repository.create(user).await
