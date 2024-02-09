import basolato/view
import ../navbar/navbar_view_model

type ApplicationViewModel* = object
  title*:string
  navbarViewModel*:NavbarViewModel

proc new*(_:type ApplicationViewModel, title:string, isLogin:bool, name:string):ApplicationViewModel =
  let navbarViewModel = NavbarViewModel.new(isLogin, name)
  return ApplicationViewModel(
    title:title,
    navbarViewModel:navbarViewModel
  )
