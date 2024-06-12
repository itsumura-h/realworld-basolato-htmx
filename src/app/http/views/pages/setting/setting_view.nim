import basolato/view
import ../../layouts/app/app_view_model
import ../../layouts/app/app_view
import ../../islands/setting/setting_view


proc settingView*(appViewModel:AppViewModel):Component =
  return appView(appViewModel, islandSettingView())
