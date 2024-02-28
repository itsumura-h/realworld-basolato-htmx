type LoginUserDto*  = object
  id*:string
  name*:string
  email*:string
  bio*:string
  image*:string

proc new*(_:type LoginUserDto, id:string, name: string, email: string, bio: string, image: string): LoginUserDto =
  return LoginUserDto(
    id: id,
    name: name,
    email: email,
    bio: bio,
    image: image
  )
