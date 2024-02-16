type Image* = object
  value*:string

proc init*(_:type Image, value:string):Image =
  return Image(value:value)
