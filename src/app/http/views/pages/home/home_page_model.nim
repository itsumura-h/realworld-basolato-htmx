type HomePageModel* = object
  isLogin*: bool

proc new*(_:type HomePageModel, isLogin:bool):HomePageModel =
  return HomePageModel(isLogin:isLogin)
