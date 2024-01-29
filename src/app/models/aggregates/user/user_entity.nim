import ./vo/user_id
import ./vo/user_name
import ./vo/email
import ./vo/password


type DraftUser* = object
  id*:UserId
  name*:UserName
  email*:Email
  password*:Password


proc new*(_:type DraftUser, userId:UserId, userName:UserName, email:Email, password:Password):DraftUser =
  return DraftUser(
    userId:userId,
    userName:userName,
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
    userId:userId,
    name:userName,
    email:email,
    password:password,
  )
