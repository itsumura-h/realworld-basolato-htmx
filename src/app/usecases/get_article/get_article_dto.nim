import std/times

type TagDto* = object
  tagId*:int
  articleId*:string
  tagName*:string

proc new*(_:type TagDto, tagId:int, articleId:string, tagName:string):TagDto =
  return TagDto(
    tagId:tagId,
    articleId:articleId,
    tagName:tagName
  )


type ArticleDto* = object
  id*:string
  title*:string
  description*:string
  body*:string
  createdAt*:DateTime
  tags*:seq[TagDto]

proc new*(_:type ArticleDto, id, title, description, body, createdAt:string, tags:seq[TagDto]):ArticleDto =
  let createdAt = parse(createdAt, "yyyy-MM-dd hh:mm:ss")
  return ArticleDto(
    id:id,
    title:title,
    description:description,
    body:body,
    createdAt:createdAt,
    tags:tags,
  )


type UserDto* = object
  id*:string
  name*:string
  image*:string
  followerCount*:int

proc new*(_:type UserDto, id, name, image:string, followerCount:int):UserDto =
  return UserDto(
    id:id,
    name:name,
    image:image,
    followerCount:followerCount,
  )


type GetArticleDto* = object
  article*:ArticleDto
  user*:UserDto

proc new*(_:type GetArticleDto, article:ArticleDto, user:UserDto):GetArticleDto =
  return GetArticleDto(
    article:article,
    user:user
  )
