import ../../../../usecases/get_user_show/get_user_show_dto
import ../../../../usecases/get_favorites_in_user/get_favorites_in_user_dto
import ../../components/user/follow_button/follow_button_view_model
import ../../../../usecases/get_follow_button_in_user/follow_button_in_user_dto


type User*  = object
  id*:string
  name*:string
  bio*:string
  image*:string
  isSelf*:bool

proc new*(_:type User, id:string, name:string, bio:string, image:string, isSelf:bool):User =
  return User(
    id:id,
    name:name,
    bio:bio,
    image:image,
    isSelf:isSelf,
  )


type UserShowViewModel*  = object
  user*:User
  followButtonViewModel*:FollowButtonViewModel
  loadFavorites*:bool

proc new*(_:type UserShowViewModel, dto:GetUserShowDto, followButtonDto:FollowButtonInUserDto, isSelf:bool, loadFavorites:bool):UserShowViewModel =
  let user = User.new(
    dto.id,
    dto.name,
    dto.bio,
    dto.image,
    isSelf
  )

  let followButtonViewModel = FollowButtonViewModel.new(followButtonDto)

  let viewModel = UserShowViewModel(
    user:user,
    followButtonViewModel:followButtonViewModel,
    loadFavorites:loadFavorites,
  )
  return viewModel
