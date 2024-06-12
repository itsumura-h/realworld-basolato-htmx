import std/options
import ../../../../errors

type User* = object
  id*:string

type Tag* = object
  id*:string
  name*:string

type FeedType* = enum
  YourFeed,
  GlobalFeed,
  TagFeed,


type FeedNavbarViewModel* = object
  feedType*:FeedType
  loginUser:Option[User]
  tag:Option[Tag]

proc globalFeed*(_:type FeedNavbarViewModel, loginUserId:Option[string]):FeedNavbarViewModel =
  let feedType = GlobalFeed
  let loginUser =
    if loginUserId.isSome():
      let loginUserId = loginUserId.get()
      User(id:loginUserId).some()
    else:
      none(User)
  let tag = none(Tag)
  return FeedNavbarViewModel(
    feedType:feedType,
    loginUser:loginUser,
    tag:tag,
  )


proc yourFeed*(_:type FeedNavbarViewModel, loginUserId:string):FeedNavbarViewModel =
  let feedType = YourFeed
  let loginUser = User(id:loginUserId).some()
  let tag = none(Tag)
  return FeedNavbarViewModel(
    feedType:feedType,
    loginUser:loginUser,
    tag:tag,
  )


proc tagFeed*(_:type FeedNavbarViewModel, loginUser:Option[string], tagId, tagName:string):FeedNavbarViewModel =
  let feedType = TagFeed
  let loginUser =
    if loginUser.isSome():
      User(id:loginUser.get()).some()
    else:
      none(User)
  let tag = Tag(id:tagId, name:tagName).some()
  return FeedNavbarViewModel(
    feedType:feedType,
    loginUser:loginUser,
    tag:tag,
  )


proc isLogin*(self:FeedNavbarViewModel):bool =
  return self.loginUser.isSome()

proc loginUser*(self:FeedNavbarViewModel):User =
  if not self.loginUser.isSome():
    raise newException(DomainError, "loginUser is None")
  return self.loginUser.get()

proc tag*(self:FeedNavbarViewModel):Tag =
  if not self.tag.isSome():
    raise newException(DomainError, "tag is None")
  return self.tag.get()
