import basolato/view
import ../../layouts/app/app_view_model
import ../../layouts/app/app_view
import ../../islands/register/register_view


proc registerView*(appViewModel:AppViewModel):Component =
  return appView(appViewModel, islandRegisterView())
