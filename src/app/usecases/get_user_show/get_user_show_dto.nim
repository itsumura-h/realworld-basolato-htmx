type GetUserShowDto*  = object
  id*:string
  name*:string
  bio*:string
  image*:string

proc new*(_:type GetUserShowDto,
  id:string,
  name:string,
  bio:string,
  image:string,
):GetUserShowDto =
  return GetUserShowDto(
    id:id, 
    name:name,
    bio:bio,
    image:image,
  )
