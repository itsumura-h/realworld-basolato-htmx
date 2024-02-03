type UserFeedNavbar* = object
  title*:string
  isActive*:bool
  url*:string
  hxGetUrl*:string

proc new*(_:type UserFeedNavbar, title:string, isActive:bool, url:string, hxGetUrl:string):UserFeedNavbar =
  return UserFeedNavbar(
    title:title,
    isActive:isActive,
    url:url,
    hxGetUrl:hxGetUrl,
  )


type UserFeedNavigationViewModel* = object
  userFeedNavbarItems*:seq[UserFeedNavbar]

proc new*(_:type UserFeedNavigationViewModel, userFeedNavbarItems:seq[UserFeedNavbar]):UserFeedNavigationViewModel =
  return UserFeedNavigationViewModel(
    userFeedNavbarItems:userFeedNavbarItems
  )
