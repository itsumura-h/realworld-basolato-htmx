import basolato/view
import ../../layouts/app/app_view_model
import ../../layouts/app/app_view
import ../../islands/login/login_view


proc loginView*(appViewModel:AppViewModel):Component =
  return appView(appViewModel, islandLoginView())
