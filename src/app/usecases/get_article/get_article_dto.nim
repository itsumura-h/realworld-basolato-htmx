import std/times

type TagDto*  = object
  tagId*:int
  articleId*:string
  tagName*:string

proc init*(_:type TagDto, tagId:int, articleId:string, tagName:string):TagDto =
  return TagDto(
    tagId:tagId,
    articleId:articleId,
    tagName:tagName
  )


type ArticleDto*  = object
  id*:string
  title*:string
  description*:string
  body*:string
  createdAt*:DateTime
  tags*:seq[TagDto]
  # by user
  isFavorited*:bool
  favoriteCount*:int

proc init*(_:type ArticleDto,
  id:string,
  title:string,
  description:string,
  body:string,
  createdAt:string,
  tags:seq[TagDto],
  isFavorited:bool,
  favoriteCount:int
):ArticleDto =
  let createdAt = parse(createdAt, "yyyy-MM-dd hh:mm:ss")
  return ArticleDto(
    id:id,
    title:title,
    description:description,
    body:body,
    createdAt:createdAt,
    tags:tags,
    isFavorited:isFavorited,
    favoriteCount:favoriteCount
  )


type UserDto*  = object
  id*:string
  name*:string
  image*:string
  followerCount*:int

proc init*(_:type UserDto, id, name, image:string, followerCount:int):UserDto =
  return UserDto(
    id:id,
    name:name,
    image:image,
    followerCount:followerCount,
  )


type GetArticleDto*  = object
  article*:ArticleDto
  user*:UserDto

proc init*(_:type GetArticleDto, article:ArticleDto, user:UserDto):GetArticleDto =
  return GetArticleDto(
    article:article,
    user:user
  )
