type FavoriteButtonViewModel* = object
  isFavorited*:bool
  articleId*:string
  isCurrentUser*:bool
  favoriteCount*:int

proc new*(_:type FavoriteButtonViewModel,
  isFavorited:bool,
  articleId:string,
  isCurrentUser:bool,
  favoriteCount:int,
):FavoriteButtonViewModel =
  return FavoriteButtonViewModel(
    isFavorited:isFavorited,
    articleId:articleId,
    isCurrentUser:isCurrentUser,
    favoriteCount:favoriteCount,
  )
