import std/times
import ../../../../usecases/get_comments_in_article/get_comments_in_article_dto


type User* = object
  name*:string
  username*:string
  image*:string

proc new*(_:type User, name, username, image:string):User =
  return User(
    name:name,
    username:username,
    image:image
  ) 


type Article* = object
  id*:string
  user*:User

proc new*(_:type Article, id:string, user:User):Article =
  return Article(
    id:id,
    user:user
  )


type Comment* = object
  user*:User
  body*:string
  createdAt*:string

proc new*(_:type Comment, user:User, body:string, createdAt:DateTime):Comment =
  let createdAt = createdAt.format("yyyy MMMM d")
  return Comment(
    user:user,
    body:body,
    createdAt:createdAt
  )


type CommentViewModel* = object
  comments*:seq[Comment]
  article*:Article
  isLogin*:bool

proc new*(_:type CommentViewModel, dto:GetCommentsInArticleDto, isLogin:bool):CommentViewModel =
  var comments:seq[Comment]
  for row in dto.comments:
    let user = User.new(
      row.user.name,
      row.user.username,
      row.user.image
    )
    comments.add(
      Comment.new(
        user,
        row.body,
        row.createdAt
      )
    )
  let author = User.new(
    dto.article.user.name,
    dto.article.user.username,
    dto.article.user.image,
  )
  let article = Article.new(
    dto.article.id,
    author
  )
  return CommentViewModel(
    comments:comments,
    article:article,
    isLogin:isLogin
  )
