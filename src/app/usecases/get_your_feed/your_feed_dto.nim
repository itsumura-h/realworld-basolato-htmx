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

proc new*(_:type ArticleWithAuthorDto,
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

proc new*(_:type PaginatorDto, hasPages:bool, current:int, lastPage:int):PaginatorDto =
  return PaginatorDto(
    hasPages:hasPages,
    current:current,
    lastPage:lastPage
  )



type YourFeedDto*  = object
  articlesWithAuthor*:seq[ArticleWithAuthorDto]
  feedPaginator*:PaginatorDto

proc new*(_:type YourFeedDto,
  articlesWithAuthor:seq[ArticleWithAuthorDto],
  feedPaginator:PaginatorDto
):YourFeedDto =
  return YourFeedDto(
    articlesWithAuthor:articlesWithAuthor,
    feedPaginator:feedPaginator
  )
