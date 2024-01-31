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
