import ../../../../../usecases/get_follow_button_in_user/follow_button_in_user_dto


type FollowButtonViewModel*  = object
  userId*: string
  userName*: string
  isFollowed*: bool
  followerCount*: int

proc new*(_:type FollowButtonViewModel, dto:FollowButtonInUserDto):FollowButtonViewModel =
  return FollowButtonViewModel(
    userId:dto.userId,
    userName:dto.userName,
    isFollowed:dto.isFollowed,
    followerCount: dto.followerCount,
  )
