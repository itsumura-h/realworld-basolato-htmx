import ../../../../../models/dto/favorite_button/favorite_button_dto


type FavoriteButtonViewModel* = object
  articleId*:string
  count*:int
  isFavorited*:bool


proc new*(
  _:type FavoriteButtonViewModel,
  articleId:string,
  count:int,
  isFavorited:bool,
): FavoriteButtonViewModel =
  return FavoriteButtonViewModel(
    articleId: articleId,
    count: count,
    isFavorited: isFavorited,
  )


proc new*(_:type FavoriteButtonViewModel, dto:FavoriteButtonDto): FavoriteButtonViewModel =
  return FavoriteButtonViewModel(
    articleId: dto.articleId,
    count: dto.favoriteCount,
    isFavorited: dto.isFavorited,
  )
