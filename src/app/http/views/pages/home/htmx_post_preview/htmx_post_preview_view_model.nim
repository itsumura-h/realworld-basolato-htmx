import std/times
import ../../../components/home/feed_navigation/feed_navigation_view_model
import ../../../../../usecases/get_global_feed/get_global_feed_dto
import ../../../../../usecases/get_tag_feed/get_tag_feed_dto


type Tag*  = object
  name*:string

proc init*(_:type Tag, name:string):Tag =
  return Tag(
    name:name
  )


type User*  = object
  id*:string
  name*:string
  image*:string

proc init*(_:type User, id:string, name:string, image:string):User =
  let user = User(
    id:id,
    name:name,
    image:image
  )
  return user


type Article*  = object
  id*:string
  title*:string
  description*:string
  createdAt*:string = "1970 January 1"
  popularCount*:int
  user*:User
  tags*:seq[Tag]

proc init*(_:type Article,
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


type Paginator*  = object
  hasPages*:bool
  current*:int
  lastPage*:int

proc init*(_:type Paginator, hasPages:bool, current:int, lastPage:int):Paginator =
  return Paginator(
    hasPages:hasPages,
    current:current,
    lastPage:lastPage
  )


type HtmxPostPreviewViewModel*  = object
  articles*:seq[Article]
  paginator*:Paginator
  feedNavbarItems*:seq[FeedNavbar]

proc init*(_:type HtmxPostPreviewViewModel, globalFeedDto:GlobalFeedDto):HtmxPostPreviewViewModel =
  var articles:seq[Article]
  for row in globalFeedDto.articlesWithAuthor:
    let user = User.init(
      id = row.author.id,
      name = row.author.name,
      image = row.author.image
    )
    var tags:seq[Tag]
    for row in row.tags:
      let tag = Tag.init(row.name)
      tags.add(tag)

    let article = Article.init(
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
    FeedNavbar.init(
      title = "Global Feed",
      isActive = true,
      hxGetUrl = "/htmx/home/global-feed",
      hxPushUrl = "/"
    )
  ]

  let paginator = Paginator.init(
    hasPages = globalFeedDto.globalFeedPaginator.hasPages,
    current = globalFeedDto.globalFeedPaginator.current,
    lastPage = globalFeedDto.globalFeedPaginator.lastPage
  )

  return HtmxPostPreviewViewModel(
    articles:articles,
    paginator:paginator,
    feedNavbarItems:feedNavbarItems
  )


proc init*(_:type HtmxPostPreviewViewModel, tagFeedDto:TagFeedDto, tagName:string):HtmxPostPreviewViewModel =
  var articles:seq[Article]
  for row in tagFeedDto.articlesWithAuthor:
    let user = User.init(
      id = row.author.id,
      name = row.author.name,
      image = row.author.image
    )
    var tags:seq[Tag]
    for row in row.tags:
      let tag = Tag.init(row.name)
      tags.add(tag)

    let article = Article.init(
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
    FeedNavbar.init(
      title = "Global Feed",
      isActive = false,
      hxGetUrl = "/htmx/home/global-feed",
      hxPushUrl = "/"
    ),
    FeedNavbar.init(
      title = tagName,
      isActive = true,
      hxGetUrl = "/htmx/tag-feed",
      hxPushUrl = "/tag-feed/" & tagName,
    ),
  ]

  let paginator = Paginator.init(
    hasPages = tagFeedDto.paginator.hasPages,
    current = tagFeedDto.paginator.current,
    lastPage = tagFeedDto.paginator.lastPage
  )

  return HtmxPostPreviewViewModel(
    articles:articles,
    paginator:paginator,
    feedNavbarItems:feedNavbarItems
  )
