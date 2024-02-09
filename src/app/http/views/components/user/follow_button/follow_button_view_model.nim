type FollowButtonViewModel* = object
  userName*: string
  isFollowed*: bool
  followerCount*: int


proc new*(_:type FollowButtonViewModel, userName: string, isFollowed: bool, followerCount: int): FollowButtonViewModel =
  return FollowButtonViewModel(
    userName: userName,
    isFollowed: isFollowed,
    followerCount: followerCount
  )
