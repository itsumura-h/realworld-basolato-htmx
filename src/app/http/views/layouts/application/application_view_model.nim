import basolato/view
import ../navbar/navbar_view_model
import ../../../../usecases/get_login_user/get_login_user_dto


type ApplicationViewModel*  = object
  title*:string
  navbarViewModel*:NavbarViewModel

proc init*(_:type ApplicationViewModel, title:string, user:LoginUserDto):ApplicationViewModel =
  ## if login
  let navbarViewModel = NavbarViewModel.init(true, user.name, user.image)
  return ApplicationViewModel(
    title:title,
    navbarViewModel:navbarViewModel
  )


proc init*(_:type ApplicationViewModel, title:string):ApplicationViewModel =
  ## if not login
  let navbarViewModel = NavbarViewModel.init(false, "", "")
  return ApplicationViewModel(
    title:title,
    navbarViewModel:navbarViewModel
  )
