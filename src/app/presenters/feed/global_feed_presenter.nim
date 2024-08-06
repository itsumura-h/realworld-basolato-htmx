import std/asyncdispatch
import std/sequtils
import basolato/view
import ../../consts
import ../../di_container
import ../../models/dto/article/article_list_query_interface
import ../../models/dto/article/article_count_query_interface
import ../../models/dto/article/article_dto
import ../../http/views/templates/feed/feed_template_model
import ../../http/views/components/feed_article/feed_article_component_model
import ../../http/views/components/paginator/paginator_component_model


type GlobalFeedPresenter* = object
  articleListQuery: IGlobalFeedArticleListQuery
  articleCountQuery: IGlobalFeedArticleCountQuery

proc new*(_:type GlobalFeedPresenter):GlobalFeedPresenter =
  return GlobalFeedPresenter(
    articleListQuery: di.globalFeedArticleListQuery,
    articleCountQuery: di.globalFeedArticleCountQuery
  )


proc invoke*(self: GlobalFeedPresenter):Future[FeedTemplateModel] {.async.} =
  let context = context()
  let isLogin = context.isLogin().await
  let loginUserId = context.get("user_id").await
  let page = context.params.getInt("page", 1)
  let offset = (page - 1) * FEED_DISPLAY_COUNT

  let articleDtoList = self.articleListQuery.invoke(offset, FEED_DISPLAY_COUNT, isLogin, loginUserId).await

  let articleList = articleDtoList.map(
    proc(article:ArticleDto):FeedArticleComponentModel =
      let tagList = article.tagList.map(
        proc(tag:TagDto):string =
          tag.name
      )
      return FeedArticleComponentModel.new(
        article.id,
        article.title,
        article.description,
        article.createdAt,
        article.author.id,
        article.author.name,
        article.author.image,
        article.popularCount,
        article.isLoginUserLiked,
        tagList,
      )
  )

  let totalCount = self.articleCountQuery.invoke().await

  let paginatorModel = PaginatorComponentModel.new(
    currentPage = page,
    total = totalCount,
  )

  let model = FeedTemplateModel.new(
    articleList = articleList,
    paginatorModel = paginatorModel,
    feedType = FeedType.global,
    tagName = ""
  )
  .await

  return model
