import std/asyncdispatch
import std/options
import ../../../di_container
import ./vo/user_id
import ./vo/email
import ./user_repository_interface


type UserService* = object
  repository: IUserRepository

proc new*(_:type UserService):UserService =
  return UserService(
    repository: di.userRepository
  )


proc isEmailUnique*(self:UserService, email:Email):Future[bool] {.async.} =
  let user = self.repository.getUserByEmail(email).await
  return not user.isSome()


proc isExistsUser*(self:UserService, userId:UserId):Future[bool] {.async.} =
  let userOpt = self.repository.getUserById(userId).await
  return userOpt.isSome()
