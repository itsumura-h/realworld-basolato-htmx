import std/times
import ../get_favorite_button/favorite_button_dto


type TagDto*  = object
  tagId*:string
  articleId*:string
  tagName*:string

proc new*(_:type TagDto, tagId:string, articleId:string, tagName:string):TagDto =
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
  favoriteButtonDto*: FavoriteButtonDto

proc new*(_:type ArticleDto,
  id:string,
  title:string,
  description:string,
  body:string,
  createdAt:string,
  tags:seq[TagDto],
  favoriteButtonDto: FavoriteButtonDto,
):ArticleDto =
  let createdAt = parse(createdAt, "yyyy-MM-dd hh:mm:ss")
  return ArticleDto(
    id:id,
    title:title,
    description:description,
    body:body,
    createdAt:createdAt,
    tags:tags,
    favoriteButtonDto:favoriteButtonDto,
  )


type UserDto*  = object
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


type GetArticleInFeedDto*  = object
  article*:ArticleDto
  user*:UserDto

proc new*(_:type GetArticleInFeedDto, article:ArticleDto, user:UserDto):GetArticleInFeedDto =
  return GetArticleInFeedDto(
    article:article,
    user:user
  )
