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
  popularTagsCount*:int
  user*:User
  tags*:seq[Tag]

proc new*(_:type Article,
  id:string,
  title:string,
  description:string,
  createdAt:string,
  popularTagsCount:int,
  user:User,
  tags:seq[Tag]
):Article =
  let createdAt = parse(createdAt, "yyyy-MM-dd hh:mm:ss")
  let artilce = Article(
    id:id,
    title:title,
    description:description,
    createdAt:createdAt.format("MMMM d"),
    popularTagsCount:popularTagsCount,
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


type FeedNavbar* = object
  title*:string
  isActive*:bool
  hxGetUrl*:string
  hxPushUrl*:string

proc new*(_:type FeedNavbar,
  title:string,
  isActive:bool,
  hxGetUrl:string,
  hxPushUrl:string
):FeedNavbar =
  return FeedNavbar(
    title:title,
    isActive:isActive,
    hxGetUrl:hxGetUrl,
    hxPushUrl:hxPushUrl
  )


type HtmxGlobalFeedViewModel* = object
  articles*:seq[Article]
  paginator*:Paginator
  feedNavbarItems*:seq[FeedNavbar]

proc new*(_:type HtmxGlobalFeedViewModel,
  articles:seq[Article],
  paginator:Paginator,
  feedNavbarItems:seq[FeedNavbar]
):HtmxGlobalFeedViewModel =
  return HtmxGlobalFeedViewModel(
    articles:articles,
    paginator:paginator,
    feedNavbarItems:feedNavbarItems
  )
