import std/times

type UserDto* = object
  id*:string
  name*:string
  image*:string

proc new*(_:type UserDto, id, name, image:string):UserDto =
  return UserDto(
    id:id,
    name:name,
    image:image
  )


type ArticleDto* = object
  id*:string
  user*:UserDto

proc new*(_:type ArticleDto, id:string, user:UserDto):ArticleDto =
  return ArticleDto(
    id:id,
    user:user
  )


type CommentDto* = object
  user*:UserDto
  body*:string
  createdAt*:DateTime

proc new*(_:type CommentDto, user:UserDto, body:string, createdAt:DateTime):CommentDto =
  return CommentDto(
    user:user,
    body:body,
    createdAt:createdAt
  )


type GetCommentsInArticleDto* = object
  comments*:seq[CommentDto]
  article*:ArticleDto

proc new*(_:type GetCommentsInArticleDto, comments:seq[CommentDto], article:ArticleDto):GetCommentsInArticleDto =
  return GetCommentsInArticleDto(
    comments:comments,
    article:article
  )
