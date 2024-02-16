type LoginUserDto* = object
  name*:string
  email*:string
  bio*:string
  image*:string

proc init*(_:type LoginUserDto, name: string, email: string, bio: string, image: string): LoginUserDto =
  return LoginUserDto(
    name: name,
    email: email,
    bio: bio,
    image: image
  )
