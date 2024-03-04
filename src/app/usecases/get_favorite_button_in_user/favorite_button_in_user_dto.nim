type FavoriteButtonInUserDto* = object
  isFavorited*: bool
  articleId*: string
  isCurrentUser*: bool
  favoriteCount*: int

proc new*(_:type FavoriteButtonInUserDto,
  isFavorited: bool,
  articleId: string,
  isCurrentUser: bool,
  favoriteCount: int
): FavoriteButtonInUserDto =
  return FavoriteButtonInUserDto(
    isFavorited: isFavorited,
    articleId: articleId,
    isCurrentUser: isCurrentUser,
    favoriteCount: favoriteCount
  )
