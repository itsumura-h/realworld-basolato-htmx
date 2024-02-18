import std/times
import ../../../../usecases/get_comments_in_article/get_comments_in_article_dto


type User*  = object
  id*:string
  name*:string
  image*:string

proc init*(_:type User, id, name, image:string):User =
  return User(
    id:id,
    name:name,
    image:image
  ) 


type Article*  = object
  id*:string
  user*:User

proc init*(_:type Article, id:string, user:User):Article =
  return Article(
    id:id,
    user:user
  )


type Comment*  = object
  user*:User
  body*:string
  createdAt*:string

proc init*(_:type Comment, user:User, body:string, createdAt:DateTime):Comment =
  let createdAt = createdAt.format("yyyy MMMM d")
  return Comment(
    user:user,
    body:body,
    createdAt:createdAt
  )


type CommentViewModel*  = object
  comments*:seq[Comment]
  article*:Article
  isLogin*:bool

proc init*(_:type CommentViewModel, dto:GetCommentsInArticleDto, isLogin:bool):CommentViewModel =
  var comments:seq[Comment]
  for row in dto.comments:
    let user = User.init(
      row.user.id,
      row.user.name,
      row.user.image
    )
    comments.add(
      Comment.init(
        user,
        row.body,
        row.createdAt
      )
    )
  let author = User.init(
    dto.article.user.id,
    dto.article.user.name,
    dto.article.user.image,
  )
  let article = Article.init(
    dto.article.id,
    author
  )
  return CommentViewModel(
    comments:comments,
    article:article,
    isLogin:isLogin
  )
