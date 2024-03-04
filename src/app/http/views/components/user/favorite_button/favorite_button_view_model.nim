import ../../../../../usecases/get_favorite_button_in_user/favorite_button_in_user_dto


type FavoriteButtonViewModel*  = object
  isFavorited*: bool
  articleId*: string
  isCurrentUser*: bool
  favoriteCount*: int

proc new*(_:type FavoriteButtonViewModel,
  isFavorited: bool,
  articleId: string,
  isCurrentUser: bool,
  favoriteCount: int
): FavoriteButtonViewModel =
  return FavoriteButtonViewModel(
    isFavorited: isFavorited,
    articleId: articleId,
    isCurrentUser: isCurrentUser,
    favoriteCount: favoriteCount
  )



proc new*(_:type FavoriteButtonViewModel, dto:FavoriteButtonInUserDto): FavoriteButtonViewModel =
  return FavoriteButtonViewModel(
    isFavorited: dto.isFavorited,
    articleId: dto.articleId,
    isCurrentUser: dto.isCurrentUser,
    favoriteCount: dto.favoriteCount
  )
