import ../../../../errors


type HashedPassword*  = object
  value*:string

proc init*(_:type HashedPassword, value:string):HashedPassword =
  if value.len == 0:
    raise newException(DomainError, "password is empty")
  
  return HashedPassword(value:value)
