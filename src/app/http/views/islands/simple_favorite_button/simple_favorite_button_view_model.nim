import ../../../../models/dto/favorite_button/favorite_button_dto


type SimpleFavoriteButtonViewModel* = object
  articleId*:string
  count*:int
  isFavorited*:bool
  willDelete*:bool

proc new*(_:type SimpleFavoriteButtonViewModel, dto:FavoriteButtonDto, willDelete=false): SimpleFavoriteButtonViewModel =
  ## willDelete is only in /users/{article} favorite articles
  return SimpleFavoriteButtonViewModel(
    articleId: dto.articleId,
    count: dto.favoriteCount,
    isFavorited: dto.isFavorited,
    willDelete: willDelete,
  )
