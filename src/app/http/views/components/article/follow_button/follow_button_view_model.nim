type FollowButtonViewModel*  = object
  userId*:string
  userName*:string
  isFollowed*:bool
  followerCount*:int

proc new*(_:type FollowButtonViewModel, userId:string, userName:string, isFollowed:bool, followerCount:int): FollowButtonViewModel =
  return FollowButtonViewModel(
    userId:userId,
    userName:userName,
    isFollowed:isFollowed,
    followerCount:followerCount
  )
