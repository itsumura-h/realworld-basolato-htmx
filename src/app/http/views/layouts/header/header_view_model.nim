import std/options

type User* = object
  id*:string
  name*:string
  imageUrl*:string

type HeaderViewModel* = object
  user:Option[User]


proc new*(_:type HeaderViewModel, id, name, imageUrl:string):HeaderViewModel =
  let user = User(
    id:id,
    name:name,
    imageUrl:imageUrl,
  )
  let userOpt = user.some()
  let viewModel = HeaderViewModel(
    user:userOpt,
  )
  return viewModel


proc new*(_:type HeaderViewModel):HeaderViewModel =
  let user = none(User)
  let viewModel = HeaderViewModel(
    user:user,
  )
  return viewModel


proc isLogin*(self:HeaderViewModel):bool =
  return self.user.isSome()


proc user*(self:HeaderViewModel):User =
  return self.user.get()
