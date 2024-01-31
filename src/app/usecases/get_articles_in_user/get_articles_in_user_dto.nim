type GetArticlesInUserDto* = object
  id*:string
  name*:string
  bio*:string
  image*:string
  isFollowed*:bool
  followerCount*:int

proc new*(_:type GetArticlesInUserDto,
  id:string,
  name:string,
  bio:string,
  image:string,
  isFollowed:bool,
  followerCount:int,
):GetArticlesInUserDto =
  return GetArticlesInUserDto(
    id:id, 
    name:name,
    bio:bio,
    image:image,
    isFollowed:isFollowed,
    followerCount:followerCount,
  )
