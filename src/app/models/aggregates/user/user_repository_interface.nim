import std/asyncdispatch
import std/options
import std/json
import interface_implements
import ./user_entity
import ./vo/email
import ./vo/user_id


interfaceDefs:
  type IUserRepository* = object of RootObj
    getUserByEmail:proc(self:IUserRepository, email:Email):Future[Option[JsonNode]]
    getUserById:proc(self:IUserRepository, userId:UserId):Future[Option[User]]
    create:proc(self:IUserRepository, user:DraftUser):Future[void]
