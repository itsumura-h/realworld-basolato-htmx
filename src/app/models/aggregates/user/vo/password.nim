import ../../../../errors
import basolato/password


type Password* = object
  value:string


proc new*(_:type Password, value:string):Password =
  if value.len == 0:
    raise newException(DomainError, "password is empty")
  
  return Password(value:value)

proc value*(self:Password):string =
  return self.value

proc hashed*(self:Password):string =
  return genHashedPassword(self.value)
