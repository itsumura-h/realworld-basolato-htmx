import ../../../../errors

type Description* = object
  value*:string

proc init*(_:type Description, value:string):Description =
  return Description(value:value)
