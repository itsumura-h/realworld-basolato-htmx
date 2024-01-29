import ../../../../errors

type UserId* = object
  value*:string

proc new*(_:type UserId, value:string):UserId =
  if value.len == 0:
    raise newException(DomainError, "id is empty")

  return UserId(
    value:value
  )
