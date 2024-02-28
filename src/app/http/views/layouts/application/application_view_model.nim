import basolato/view
import ../navbar/navbar_view_model
import ../../../../usecases/get_login_user/get_login_user_dto


type ApplicationViewModel*  = object
  title*:string
  navbarViewModel*:NavbarViewModel

proc new*(_:type ApplicationViewModel, title:string, user:LoginUserDto):ApplicationViewModel =
  ## if login
  let navbarViewModel = NavbarViewModel.new(true, user.id, user.name, user.image)
  return ApplicationViewModel(
    title:title,
    navbarViewModel:navbarViewModel
  )


proc new*(_:type ApplicationViewModel, title:string):ApplicationViewModel =
  ## if not login
  let navbarViewModel = NavbarViewModel.new(false, "", "", "")
  return ApplicationViewModel(
    title:title,
    navbarViewModel:navbarViewModel
  )
