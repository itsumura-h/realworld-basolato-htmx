import basolato/view
import ../../layouts/app/app_view_model
import ../../layouts/app/app_view
import ../../islands/article/article_view
import ../../islands/article/article_view_model


proc articleView*(appViewModel:AppViewModel, articleViewModel:ArticleViewModel):Component =
  return appView(appViewModel, islandArticleView(articleViewModel))
