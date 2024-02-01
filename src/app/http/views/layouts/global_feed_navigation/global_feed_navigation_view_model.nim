type GlobalFeedNavbar* = object
  title*:string
  isActive*:bool
  hxGetUrl*:string
  hxPushUrl*:string

proc new*(_:type GlobalFeedNavbar,
  title:string,
  isActive:bool,
  hxGetUrl:string,
  hxPushUrl:string
):GlobalFeedNavbar =
  return GlobalFeedNavbar(
    title:title,
    isActive:isActive,
    hxGetUrl:hxGetUrl,
    hxPushUrl:hxPushUrl
  )
