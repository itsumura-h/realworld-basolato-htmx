import ../../../value_objects/user_name
import ../../../value_objects/email
import ../../../value_objects/password


type CreatingUser* = object
  userName:UserName
  email:Email
  password:Password


proc new*(_:type CreatingUser, userName:UserName, email:Email, password:Password):CreatingUser =
  return CreatingUser(
    userName:userName,
    email:email,
    password:password,
  )


proc userName*(self:CreatingUser):UserName =
  return self.userName


proc email*(self:CreatingUser):Email =
  return self.email

proc password*(self:CreatingUser):Password =
  return self.password
