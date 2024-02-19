import ../../../../errors

type TagName*  = object
  value*:string

proc new*(_:type TagName, value:string):TagName =
  if value.len == 0:
    raise newException(IdNotFoundError, "Tag name cannot be empty")
  return TagName(value:value)
