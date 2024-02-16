type Bio* = object
  value*:string

proc init*(_:type Bio, value:string):Bio =
  return Bio(value:value)
