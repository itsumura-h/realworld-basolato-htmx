type FollowButtonViewModel* = object
  userName*:string
  oobSwap*:bool
  isFollowed*:bool
  followerCount*:int

proc new*(_:type FollowButtonViewModel, userName:string, oobSwap:bool, isFollowed:bool, followerCount:int): FollowButtonViewModel =
  return FollowButtonViewModel(
    userName:userName,
    oobSwap:oobSwap,
    isFollowed:isFollowed,
    followerCount:followerCount
  )
