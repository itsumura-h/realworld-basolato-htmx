import ./vo/user_id
import ./vo/user_name
import ./vo/email
import ./vo/password


type DraftUser* = object
  id*:UserId
  name*:UserName
  email*:Email
  password*:Password


proc new*(_:type DraftUser, userName:UserName, email:Email, password:Password):DraftUser =
  let userId = UserId.new(userName)
  return DraftUser(
    id:userId,
    name:userName,
    email:email,
    password:password,
  )


type User* = object
  id*:UserId
  name*:UserName
  email*:Email
  password*:Password


proc new*(_:type User, userId:UserId, userName:UserName, email:Email, password:Password):User =
  return User(
    id:userId,
    name:userName,
    email:email,
    password:password,
  )
