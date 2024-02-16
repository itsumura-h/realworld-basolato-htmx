type FavoriteButtonViewModel* = object
  isFavorited*:bool
  articleId*:string
  oobSwap*:bool
  favoriteCount*:int

proc init*(_:type FavoriteButtonViewModel,
  isFavorited:bool,
  articleId:string,
  oobSwap:bool,
  favoriteCount:int,
):FavoriteButtonViewModel =
  return FavoriteButtonViewModel(
    isFavorited:isFavorited,
    articleId:articleId,
    oobSwap:oobSwap,
    favoriteCount:favoriteCount,
  )
