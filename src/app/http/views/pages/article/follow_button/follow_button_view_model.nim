import ../../../../../models/dto/follow_button/follow_button_dto


type FollowButtonViewModel*  = object
  userName*:string
  isFollowed*:bool
  followerCount*:int
  oobSwap*:bool

# proc new*(_:type FollowButtonViewModel, userName:string, oobSwap:bool, isFollowed:bool, followerCount:int): FollowButtonViewModel =
#   return FollowButtonViewModel(
#     userName:userName,
#     oobSwap:oobSwap,
#     isFollowed:isFollowed,
#     followerCount:followerCount
#   )

proc new*(_:type FollowButtonViewModel, dto:FollowButtonDto, oobSwap:bool):FollowButtonViewModel =
  return FollowButtonViewModel(
    userName:dto.userName,
    isFollowed:dto.isFollowed,
    followerCount: dto.followerCount,
    oobSwap:oobSwap,
  )
