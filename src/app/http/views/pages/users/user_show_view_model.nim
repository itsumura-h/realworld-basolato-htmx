import ../../layouts/users/follow_button_view_model
import ../../../../usecases/get_articles_in_user/get_articles_in_user_dto


type User* = object
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


type UserShowViewModel* = object
  user*:User
  followButtonViewModel*:FollowButtonViewModel
  loadFavorites*:bool

proc new*(_:type UserShowViewModel, dto:GetArticlesInUserDto, isSelf:bool, loadFavorites:bool):UserShowViewModel =
  let user = User.new(
    dto.id,
    dto.name,
    dto.bio,
    dto.image,
    isSelf
  )

  let followButtonViewModel = FollowButtonViewModel.new(
    dto.id,
    dto.name,
    dto.isFollowed,
    dto.followerCount
  )

  let viewModel = UserShowViewModel(
    user:user,
    followButtonViewModel:followButtonViewModel,
    loadFavorites:loadFavorites,
  )
  return viewModel
