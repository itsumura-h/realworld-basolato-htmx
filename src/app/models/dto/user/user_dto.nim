type UserDto* = object
  id*:string
  name*:string
  image*:string

proc new*(_:type UserDto, id, name, image: string): UserDto =
  return UserDto(
    id:id,
    name: name,
    image: image,
  )
  