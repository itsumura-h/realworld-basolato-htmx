import ../../../../models/dto/follow_button/follow_button_dto


type DetailFollowButtonViewModel*  = object
  userId*:string
  userName*:string
  isFollowed*:bool
  followerCount*:int

proc new*(_:type DetailFollowButtonViewModel, dto:FollowButtonDto):DetailFollowButtonViewModel =
  return DetailFollowButtonViewModel(
    userId:dto.userId,
    userName:dto.userName,
    isFollowed:dto.isFollowed,
    followerCount: dto.followerCount,
  )
