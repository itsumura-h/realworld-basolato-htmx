import std/times


type TagDto*  = object
  id*:string
  name*:string


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


type ArticleDto*  = object
  id*:string
  title*:string
  description*:string
  createdAt*:DateTime
  popularCount*:int
  isLoginUserLiked*:bool
  author*:AuthorDto
  tagList*:seq[TagDto]

proc new*(_:type ArticleDto,
  id:string,
  title:string,
  description:string,
  createdAt:string,
  popularCount:int,
  isLoginUserLiked:bool,
  author:AuthorDto,
  tagList:seq[TagDto],
):ArticleDto =
  let createdAt = createdAt.parse("yyyy-MM-dd hh:mm:ss")
  return ArticleDto(
    id:id,
    title:title,
    description:description,
    createdAt:createdAt,
    popularCount:popularCount,
    isLoginUserLiked:isLoginUserLiked,
    author:author,
    tagList:tagList,
  )
