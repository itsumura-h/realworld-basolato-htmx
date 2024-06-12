import std/asyncdispatch
import std/options
import ../../http/views/layouts/app/app_view_model
import ../../http/views/layouts/header/header_view_model
import ../../models/dto/user/user_query_interface
import ../../models/vo/user_id
import ../../di_container

type AppPresenter* = object
  userQuery:IUserQuery


proc new*(_:type AppPresenter):AppPresenter =
  return AppPresenter(
    userQuery: di.userQuery
  )


proc invoke*(self:AppPresenter, loginUserId:Option[string], title:string):Future[AppViewModel] {.async.} =
  if loginUserId.isSome():
    let userId = UserId.new(loginUserId.get())
    let userDto = self.userQuery.invoke(userId).await
    let headerViewModel = HeaderViewModel.new(userDto.id, userDto.name, userDto.image)
    let appViewModel = AppViewModel.new(title, headerViewModel)
    return appViewModel
  else:
    let headerViewModel = HeaderViewModel.new()
    let appViewModel = AppViewModel.new(title, headerViewModel)
    return appViewModel
