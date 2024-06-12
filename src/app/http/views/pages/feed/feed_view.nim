import basolato/view
import ../../layouts/app/app_view_model
import ../../layouts/app/app_view
import ../../islands/feed/feed_view_model
import ../../islands/feed/feed_view


proc feedView*(appViewModel:AppViewModel, feedViewModel:FeedViewModel):Component =
  return appView(appViewModel, islandFeedView(feedViewModel))
