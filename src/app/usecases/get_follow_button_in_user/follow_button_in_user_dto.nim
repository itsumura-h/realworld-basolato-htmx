type FollowButtonInUserDto* = object
  userName*: string
  isFollowed*: bool
  followerCount*: int

proc new*(_:type FollowButtonInUserDto, userName: string, isFollowed: bool, followerCount: int): FollowButtonInUserDto =
  return FollowButtonInUserDto(
    userName: userName,
    isFollowed: isFollowed,
    followerCount: followerCount,
  )
