type FollowButtonInUserDto* = object
  userId*: string
  userName*: string
  isFollowed*: bool
  followerCount*: int

proc new*(_:type FollowButtonInUserDto, userId: string, userName:string, isFollowed: bool, followerCount: int): FollowButtonInUserDto =
  return FollowButtonInUserDto(
    userId: userId,
    userName: userName,
    isFollowed: isFollowed,
    followerCount: followerCount,
  )
