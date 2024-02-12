import std/asyncdispatch
import ../di_container
import ../errors
import ../models/aggregates/user/vo/user_id
import ../models/aggregates/user/vo/user_name
import ../models/aggregates/user/vo/email
import ../models/aggregates/user/vo/password
import ../models/aggregates/user/vo/bio
import ../models/aggregates/user/vo/image
import ../models/aggregates/user/user_entity
import ../models/aggregates/user/user_repository_interface
import ../models/aggregates/user/user_service

type UpdateUserUsecase* = object
  repository:IUserRepository
  service:UserService

proc new*(_:type UpdateUserUsecase):UpdateUserUsecase =
  return UpdateUserUsecase(
    repository: di.userRepository,
    service: UserService.new()
  )


proc invoke*(self:UpdateUserUsecase, id, name, email, password, bio, image:string) {.async.} =
  let id = UserId.new(id)
  let name = UserName.new(name)
  let email = Email.new(email)
  let password = Password.new(password).hashed()
  let bio = Bio.new(bio)
  let image = Image.new(image)

  if not self.service.isExistsUser(id).await:
    raise newException(DomainError, "user is not found")

  let user = User.new(id, name, email, password, bio, image)
  self.repository.update(user).await
