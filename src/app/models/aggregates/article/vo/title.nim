import ../../../../errors

type Title* = object
  value*:string

proc init*(_:type Title, value:string):Title =
  if value.len == 0:
    raise newException(DomainError, "Title cannot be empty")
  return Title(value:value)
