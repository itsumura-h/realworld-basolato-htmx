import ../../../../models/dto/favorite_button/favorite_button_dto


type DetailFavoriteButtonViewModel* = object
  articleId*:string
  count*:int
  isFavorited*:bool

proc new*(_:type DetailFavoriteButtonViewModel, dto:FavoriteButtonDto): DetailFavoriteButtonViewModel =
  return DetailFavoriteButtonViewModel(
    articleId: dto.articleId,
    count: dto.favoriteCount,
    isFavorited: dto.isFavorited,
  )
