import std/asyncdispatch
import ../../http/views/templates/feed/feed_template_model
import ../../di_container
import ../../data_stores/queries/article_list/global_feed/global_feed_article_list_query


type GlobalFeedPresenter* = object
  query: GlobalFeedArticleListQuery


proc new*(_:type GlobalFeedPresenter):GlobalFeedPresenter =
  return GlobalFeedPresenter(
    query: di.globalFeedArticleListQuery
  )


proc invoke*(self: GlobalFeedPresenter, isLogin:bool, loginUserId:string, offset:int, display:int):Future[FeedTemplateModel] {.async.} =
  let articleList = self.query.invoke(offset, display).await
  echo "articleList: ",articleList
  return FeedTemplateModel.new().await
