import std/times
import ../get_favorite_button/favorite_button_dto


type AuthorDto*  = object
  id*:string
  name*:string
  image*:string

proc new*(_:type AuthorDto, id, name, image:string):AuthorDto =
  return AuthorDto(
    id:id,
    name:name,
    image:image,
  )


type TagDto*  = object
  name*:string

proc new*(_:type TagDto, name:string):TagDto =
  return TagDto(
    name:name
  )


type ArticleDto*  = object
  id*:string
  title*:string
  description*:string
  createdAt*:DateTime
  tags*:seq[TagDto]
  favoriteButtonDto*:FavoriteButtonDto

proc new*(_:type ArticleDto,
  id:string,
  title:string,
  description:string,
  createdAt:string,
  tags:seq[TagDto],
  favoriteButtonDto:FavoriteButtonDto,
): ArticleDto =  
  let createdAt = createdAt.parse("yyyy-MM-dd hh:mm:ss")
  return ArticleDto(
    id:id,
    title:title,
    description:description,
    createdAt:createdAt,
    tags:tags,
    favoriteButtonDto:favoriteButtonDto,
  )



type GetArticlesInUserDto*  = object
  articles*:seq[ArticleDto]
  author*:AuthorDto

proc new*(_:type GetArticlesInUserDto, articles:seq[ArticleDto], author:AuthorDto):GetArticlesInUserDto =
  return GetArticlesInUserDto(
    articles:articles,
    author:author
  )
