import basolato/view
import ../navbar/navbar_view_model
import ../../../../usecases/get_login_user/get_login_user_dto


type AppViewModel*  = object
  title*:string
  navbarViewModel*:NavbarViewModel

proc new*(_:type AppViewModel, title:string, user:LoginUserDto):AppViewModel =
  ## if login
  let navbarViewModel = NavbarViewModel.new(true, user.id, user.name, user.image)
  return AppViewModel(
    title:title,
    navbarViewModel:navbarViewModel
  )


proc new*(_:type AppViewModel, title:string):AppViewModel =
  ## if not login
  let navbarViewModel = NavbarViewModel.new(false, "", "", "")
  return AppViewModel(
    title:title,
    navbarViewModel:navbarViewModel
  )
