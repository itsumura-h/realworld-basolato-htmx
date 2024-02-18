type GetUserShowDto*  = object
  id*:string
  name*:string
  bio*:string
  image*:string
  isFollowed*:bool
  followerCount*:int

proc init*(_:type GetUserShowDto,
  id:string,
  name:string,
  bio:string,
  image:string,
  isFollowed:bool,
  followerCount:int,
):GetUserShowDto =
  return GetUserShowDto(
    id:id, 
    name:name,
    bio:bio,
    image:image,
    isFollowed:isFollowed,
    followerCount:followerCount,
  )
