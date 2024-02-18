import std/asyncdispatch
import ../errors
import ../di_container
import ../models/aggregates/user/user_repository_interface
import ../models/aggregates/user/user_service
import ../models/aggregates/user/user_entity
import ../models/aggregates/user/vo/user_id
import ../models/aggregates/user/vo/user_name
import ../models/aggregates/user/vo/email
import ../models/aggregates/user/vo/password

type CreateUserUsecase*  = object
  repository:IUserRepository

proc init*(_:type CreateUserUsecase):CreateUserUsecase =
  return CreateUserUsecase(
    repository:di.userRepository
  )

proc invoke*(self:CreateUserUsecase, userName, email, password:string):Future[string] {.async.} =
  let userName = UserName.init(userName)
  let email = Email.init(email)
  let password = Password.init(password)

  let service = UserService.init()
  if not service.isEmailUnique(email).await:
    raise newException(DomainError, "email is deprecated")

  let user = DraftUser.init(userName, email, password)
  let id = self.repository.create(user).await
  return id.value
