import std/asyncdispatch
import basolato/view
import ../../components/feed_article/feed_article_component_model

type FeedType* = enum
  global
  yourFeed
  tag

type FeedTemplateModel* = object
  isLogin*:bool
  articleList*:seq[FeedArticleComponentModel]
  feedType*:FeedType
  tagName*:string


proc new*(_:type FeedTemplateModel):Future[FeedTemplateModel] {.async.} =
  let context = context()
  let isLogin = context.isLogin().await
  
  let feedType =
    if context.request.url.path == "/":
      global
    elif context.request.url.path == "/your-feed":
      yourFeed
    else:
      tag

  let tagName = context.params.getStr("tag")

  return FeedTemplateModel(
    isLogin: isLogin,
    articleList: @[],
    feedType: feedType,
    tagName:  tagName,
  )
