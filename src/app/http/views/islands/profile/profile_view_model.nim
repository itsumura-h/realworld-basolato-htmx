import std/options


type ProfileViewModel* = object
  loginUserId*:Option[string]

proc new*(_:type ProfileViewModel, loginUserId:Option[string]): ProfileViewModel =
  return ProfileViewModel(
    loginUserId:loginUserId
  )


proc isLogin*(self:ProfileViewModel): bool =
  return self.loginUserId.isSome()
