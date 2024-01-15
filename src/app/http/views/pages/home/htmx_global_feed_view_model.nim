import std/times


type Tag* = object
  tagId*:int
  articleId*:string
  tagName*:string


type User* = object
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


type Article* = object
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
  user:User,
  tags:seq[Tag]
):Article =
  let createdAt = parse(createdAt, "yyyy-MM-dd hh:mm:ss")
  let artilce = Article(
    id:id,
    title:title,
    description:description,
    createdAt:createdAt.format("MMMM d"),
    favoriteCount:favoriteCount,
    user:user,
    tags:tags
  )
  return artilce


type Paginator* = object
  hasPages*:bool
  current*:int
  lastPage*:int

proc new*(_:type Paginator, hasPages:bool, current:int, lastPage:int):Paginator =
  return Paginator(
    hasPages:hasPages,
    current:current,
    lastPage:lastPage
  )


type HtmxGlobalFeedViewModel* = object
  articles*:seq[Article]
  paginator*:Paginator

proc new*(_:type HtmxGlobalFeedViewModel, articles:seq[Article], paginator:Paginator):HtmxGlobalFeedViewModel =
  return HtmxGlobalFeedViewModel(
    articles:articles,
    paginator:paginator
  )
