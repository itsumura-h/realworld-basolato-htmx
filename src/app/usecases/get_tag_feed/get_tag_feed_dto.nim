import std/times


type TagDto*  = object
  id*:int
  name*:string


type AuthorDto*  = object
  id*:string
  name*:string
  image*:string

proc init*(_:type AuthorDto, id, name, image:string):AuthorDto =
  return AuthorDto(
    id:id,
    name:name,
    image:image
  )


type ArticleWithAuthorDto*  = object
  id*:string
  title*:string
  description*:string
  createdAt*:DateTime
  popularCount*:int
  author*:AuthorDto
  tags*:seq[TagDto]

proc init*(_:type ArticleWithAuthorDto,
  id:string,
  title:string,
  description:string,
  createdAt:string,
  popularCount:int,
  author:AuthorDto,
  tags:seq[TagDto]
):ArticleWithAuthorDto =
  let createdAt = parse(createdAt, "yyyy-MM-dd hh:mm:ss")
  return ArticleWithAuthorDto(
    id:id,
    title:title,
    description:description,
    createdAt:createdAt,
    popularCount:popularCount,
    author:author,
    tags:tags
  )


type PaginatorDto*  = object
  hasPages*:bool
  current*:int
  lastPage*:int

proc init*(_:type PaginatorDto, hasPages:bool, current:int, lastPage:int):PaginatorDto =
  return PaginatorDto(
    hasPages:hasPages,
    current:current,
    lastPage:lastPage
  )



type TagFeedDto*  = object
  articlesWithAuthor*:seq[ArticleWithAuthorDto]
  paginator*:PaginatorDto

proc init*(_:type TagFeedDto,
  articlesWithAuthor:seq[ArticleWithAuthorDto],
  paginator:PaginatorDto
):TagFeedDto =
  return TagFeedDto(
    articlesWithAuthor:articlesWithAuthor,
    paginator:paginator
  )
