import std/times


type Tag* = ref object
  tagId*:int
  articleId*:string
  tagName*:string


type Article* = ref object
  id*:string
  title*:string
  description*:string
  body*:string
  createdAt*:string = "1970 January 1st"
  tags*:seq[Tag]

proc new*(_:type Article, id, title, description, body, createdAt:string):Article =
  let createdAt = parse(createdAt, "yyyy-MM-dd hh:mm:ss")
  let strCreatedAt = createdAt.format("MMMM d")

  return Article(
    id:id,
    title:title,
    description:description,
    body:body,
    createdAt:strCreatedAt
  )


type User* = ref object
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


type HtmxArticleShowViewModel* = ref object
  article*:Article
  user*:User

proc new*(_:type HtmxArticleShowViewModel, article:Article, user:User):HtmxArticleShowViewModel =
  return HtmxArticleShowViewModel(
    article:article,
    user:user
  )
