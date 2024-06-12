import std/times
import ../../../../models/dto/article_with_author/article_with_author_dto
import ../../islands/simple_favorite_button/simple_favorite_button_view_model


type Author = object
  id*:string
  name*:string
  imageUrl*:string

proc new*(_:type Author, id:string, name:string, imageUrl:string):Author =
  return Author(
    id:id,
    name:name,
    imageUrl:imageUrl
  )


type Tag* = object
  name*:string

proc new*(_:type Tag, name:string):Tag =
  return Tag(
    name:name
  )


type ArticlePreviewViewModel* = object
  id*:string
  title*:string
  description*:string
  createdAt*:string
  author*:Author
  tagList*:seq[Tag]
  favoriteButtonViewModel*:SimpleFavoriteButtonViewModel

proc new*(_:type ArticlePreviewViewModel, dto:ArticleWithAuthorDto, favoriteButtonViewModel:SimpleFavoriteButtonViewModel):ArticlePreviewViewModel =
  var tagList:seq[Tag]
  for row in dto.tags:
    let tag = Tag.new(row.name)
    tagList.add(tag)

  let author = Author.new(
    id = dto.author.id,
    name = dto.author.name,
    imageUrl = dto.author.image
  )

  return ArticlePreviewViewModel(
    id: dto.id,
    title: dto.title,
    description: dto.description,
    createdAt: dto.createdAt.format("yyyy MMMM d"),
    author: author,
    tagList: tagList,
    favoriteButtonViewModel: favoriteButtonViewModel
  )
