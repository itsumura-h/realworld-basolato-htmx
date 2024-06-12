import basolato/view
import ../../layouts/app/app_view_model
import ../../layouts/app/app_view
import ../../islands/profile/profile_view_model
import ../../islands/profile/profile_view


proc profileView*(appViewModel:AppViewModel, profileViewModel:ProfileViewModel):Component =
  return appView(appViewModel, islandProfileView(profileViewModel))
