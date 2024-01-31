import std/times
import ../../layouts/feed_navigation/feed_navigation_view_model
import ../../../../usecases/get_global_feed/get_global_feed_dto


type Tag* = object
  name*:string

proc new*(_:type Tag, name:string):Tag =
  return Tag(
    name:name
  )


type User* = object
  id*:string
  name*:string
  image*:string

proc new*(_:type User, id:string, name:string, image:string):User =
  let user = User(
    id:id,
    name:name,
    image:image
  )
  return user


type Article* = object
  id*:string
  title*:string
  description*:string
  createdAt*:string = "1970 January 1"
  popularCount*:int
  user*:User
  tags*:seq[Tag]

proc new*(_:type Article,
  id:string,
  title:string,
  description:string,
  createdAt:string,
  popularCount:int,
  user:User,
  tags:seq[Tag]
):Article =
  let artilce = Article(
    id:id,
    title:title,
    description:description,
    createdAt:createdAt,
    popularCount:popularCount,
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
  feedNavbarItems*:seq[FeedNavbar]

proc new*(_:type HtmxGlobalFeedViewModel, globalFeedDto:GlobalFeedDto):HtmxGlobalFeedViewModel =
  var articles:seq[Article]
  for row in globalFeedDto.articlesWithAuthor:
    let user = User.new(
      id = row.author.id,
      name = row.author.name,
      image = row.author.image
    )
    var tags:seq[Tag]
    for row in row.tags:
      let tag = Tag.new(row.name)
      tags.add(tag)

    let article = Article.new(
      id = row.id,
      title = row.title,
      description = row.description,
      createdAt = row.createdAt.format("yyyy MMMM d"),
      popularCount = row.popularCount,
      user = user,
      tags = tags
    )
    articles.add(article)

  let feedNavbarItems = @[
    FeedNavbar.new(
      title = "Global Feed",
      isActive = true,
      hxGetUrl = "/htmx/home/global-feed",
      hxPushUrl = "/"
    )
  ]

  let paginator = Paginator.new(
    hasPages = globalFeedDto.globalFeedPaginator.hasPages,
    current = globalFeedDto.globalFeedPaginator.current,
    lastPage = globalFeedDto.globalFeedPaginator.lastPage
  )

  return HtmxGlobalFeedViewModel(
    articles:articles,
    paginator:paginator,
    feedNavbarItems:feedNavbarItems
  )
