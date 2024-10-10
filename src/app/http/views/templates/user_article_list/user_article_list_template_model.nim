import basolato/view
import ../../components/feed_article/feed_article_component_model
import ../../components/paginator/paginator_component_model

type FeedType* = enum
  myArticle
  userFavorites

type UserArticleListTemplateModel* = object
  isLogin*:bool
  articleList*:seq[FeedArticleComponentModel]
  feedType*:FeedType
  paginatorModel*:PaginatorComponentModel

proc new*(
  _:type UserArticleListTemplateModel,
  articleList:seq[FeedArticleComponentModel],
  paginatorModel:PaginatorComponentModel,
  feedType:FeedType,
):Future[UserArticleListTemplateModel] {.async.} =
  let context = context()
  let isLogin = context.isLogin().await

  return UserArticleListTemplateModel(
    isLogin: isLogin,
    articleList: articleList,
    paginatorModel: paginatorModel,
    feedType: feedType,
  )
