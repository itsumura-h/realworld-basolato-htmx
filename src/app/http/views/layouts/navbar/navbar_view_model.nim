type NavbarViewModel* = object
  isLogin*: bool
  name*:string

proc new*(_:type NavbarViewModel, isLogin: bool, name:string): NavbarViewModel =
  return NavbarViewModel(
    isLogin: isLogin,
    name:name,
  )
