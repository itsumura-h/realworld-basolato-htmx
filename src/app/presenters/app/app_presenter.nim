import std/asyncdispatch
import ../../http/views/layouts/app/app_view_model
import ../../http/views/layouts/navbar/navbar_view_model
import ../../models/dto/user/user_query_interface
import ../../di_container


type AppPresenter* = object
  userQuery:IUserQuery

proc new*(_:type AppPresenter):AppPresenter =
  return AppPresenter(
    userQuery: di.userQuery
  )


proc invoke*(self:AppPresenter, isLogin:bool, userId:string, title:string):Future[AppViewModel] {.async.} =
  if isLogin:
    let userDto = self.userQuery.invoke(userId).await
    let navbarViewModel = NavbarViewModel.new(isLogin, userDto.id, userDto.name, userDto.image)
    let appViewModel = AppViewModel.new(title, navbarViewModel)
    return appViewModel
  else:
    let navbarViewModel = NavbarViewModel.new(isLogin, "", "", "")
    let appViewModel = AppViewModel.new(title, navbarViewModel)
    return appViewModel
