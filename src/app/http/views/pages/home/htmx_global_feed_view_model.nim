import std/times


type Tag* = ref object
  tagId*:int
  articleId*:string
  tagName*:string


type User* = ref object
  id*:int
  userName*:string
  image*:string

proc new*(_:type User, id:int, name:string, image:string):User =
  let user = User(
    id:id,
    userName:name,
    image:image
  )
  return user


type Article* = ref object
  id*:string
  title*:string
  description*:string
  createdAt*:string = "1970-01-01"
  favoriteCount*:int
  user*:User
  tags*:seq[Tag]

proc new*(_:type Article,
  id:string,
  title:string,
  description:string,
  createdAt:string,
  favoriteCount:int,
  user:User
):Article =
  let createdAt = parse(createdAt, "yyyy-MM-dd hh:mm:ss")
  let artilce = Article(
    id:id,
    title:title,
    description:description,
    createdAt:createdAt.format("MMMM d"),
    favoriteCount:favoriteCount,
    user:user
  )
  return artilce


type HtmxGlobalFeedViewModel* = object
  articles*:seq[Article]

proc new*(_:type HtmxGlobalFeedViewModel, articles:seq[Article]):HtmxGlobalFeedViewModel =
  return HtmxGlobalFeedViewModel(
    articles:articles
  )
