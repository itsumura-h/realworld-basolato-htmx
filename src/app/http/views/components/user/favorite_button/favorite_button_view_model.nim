import ../../../../../data_stores/queries/get_favorite_button/favorite_button_dto


type FavoriteButtonViewModel* = object
  articleId*:string
  count*:int
  isFavorited*:bool
  willDelete*:bool

proc new*(_:type FavoriteButtonViewModel, dto:FavoriteButtonDto, willDelete=false): FavoriteButtonViewModel =
  return FavoriteButtonViewModel(
    articleId: dto.articleId,
    count: dto.favoriteCount,
    isFavorited: dto.isFavorited,
    willDelete: willDelete,
  )
