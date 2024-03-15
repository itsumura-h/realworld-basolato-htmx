type FavoriteButtonDto* = object
  articleId*: string
  favoriteCount*: int
  isFavorited*: bool

proc new*(_:type FavoriteButtonDto,
  articleId: string,
  favoriteCount: int,
  isFavorited: bool
): FavoriteButtonDto =
  return FavoriteButtonDto(
    articleId: articleId,
    favoriteCount: favoriteCount,
    isFavorited: isFavorited,
  )
