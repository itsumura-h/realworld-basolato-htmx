import std/times


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


type FavoritedUserDto*  = object
  id*:string

proc new*(_:type FavoritedUserDto, id:string):FavoritedUserDto =
  return FavoritedUserDto(
    id:id
  )


type ArticleDto*  = object
  id*:string
  title*:string
  description*:string
  createdAt*:DateTime
  author*:AuthorDto
  tags*:seq[TagDto]
  favoritedUsers*:seq[FavoritedUserDto]

proc new*(_:type ArticleDto,
  id:string,
  title:string,
  description:string,
  createdAt:string,
  author:AuthorDto,
  tags:seq[TagDto],
  favoritedUsers:seq[FavoritedUserDto]
): ArticleDto =  
  let createdAt = createdAt.parse("yyyy-MM-dd hh:mm:ss")
  return ArticleDto(
    id:id,
    title:title,
    description:description,
    createdAt:createdAt,
    author:author,
    tags:tags,
    favoritedUsers:favoritedUsers,
  )



type GetArticlesInUserDto*  = object
  articles*:seq[ArticleDto]

proc new*(_:type GetArticlesInUserDto, articles:seq[ArticleDto]):GetArticlesInUserDto =
  return GetArticlesInUserDto(
    articles:articles
  )
