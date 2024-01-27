import std/times
import std/sequtils
# import ../../../../usecases/get_global_feed/get_global_feed_dto
import ../../../../usecases/get_article/get_article_dto


type Tag* = object
  tagId*:int
  articleId*:string
  tagName*:string

proc new*(_:type Tag, tagId:int, articleId:string, tagName:string):Tag =
  return Tag(
    tagId:tagId,
    articleId:articleId,
    tagName:tagName
  )


type Article* = object
  id*:string
  title*:string
  description*:string
  body*:string
  createdAt*:string = "1970 January 1st"
  tags*:seq[Tag]

proc new*(_:type Article, id, title, description, body:string, createdAt:DateTime, tags:seq[Tag]):Article =
  let createdAt = createdAt.format("MMMM d")

  return Article(
    id:id,
    title:title,
    description:description,
    body:body,
    createdAt:createdAt,
    tags:tags,
  )


type User* = object
  id*:int
  name*:string
  username*:string
  image*:string

proc new*(_:type User, id:int, name, username, image:string):User =
  return User(
    id:id,
    name:name,
    username:username,
    image:image,
  )


type ArticleShowViewModel* = object
  article*:Article
  user*:User

proc new*(_:type ArticleShowViewModel, dto:GetArticleDto):ArticleShowViewModel =
  let tags = dto.article.tags.map(
    proc(tag:TagDto):Tag =
      return Tag.new(
        tag.tagId,
        tag.articleId,
        tag.tagName
      )
  )
  let article = Article.new(
    dto.article.id,
    dto.article.title,
    dto.article.description,
    dto.article.body,
    dto.article.createdAt,
    tags
  )
  let author = User.new(
    dto.user.id,
    dto.user.name,
    dto.user.username,
    dto.user.image,
  )
  return ArticleShowViewModel(
    article:article,
    user:author
  )
