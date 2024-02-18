type FollowButtonViewModel*  = object
  userName*: string
  isFollowed*: bool
  followerCount*: int


proc init*(_:type FollowButtonViewModel, userName: string, isFollowed: bool, followerCount: int): FollowButtonViewModel =
  return FollowButtonViewModel(
    userName: userName,
    isFollowed: isFollowed,
    followerCount: followerCount
  )
