type GetSettingDto* = object
  name*:string
  email*:string
  bio*:string
  image*:string

proc new*(_:type GetSettingDto, name: string, email: string, bio: string, image: string): GetSettingDto =
  return GetSettingDto(
    name: name,
    email: email,
    bio: bio,
    image: image
  )
