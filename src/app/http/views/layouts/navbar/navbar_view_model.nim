type NavbarViewModel* = object
  isLogin*: bool
  name*:string
  image*:string

proc init*(_:type NavbarViewModel, isLogin: bool, name:string, image:string): NavbarViewModel =
  return NavbarViewModel(
    isLogin: isLogin,
    name:name,
    image:image
  )
