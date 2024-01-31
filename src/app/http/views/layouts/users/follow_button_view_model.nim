type FollowButtonViewModel* = object
  userId*:string
  name*:string
  isFollowed*:bool
  followerCount*:int

proc new*(_:type FollowButtonViewModel, userId:string, name:string, isFollowed:bool, followerCount:int):FollowButtonViewModel =
  return FollowButtonViewModel(
    userId:userId,
    name:name,
    isFollowed:isFollowed,
    followerCount:followerCount
  )
