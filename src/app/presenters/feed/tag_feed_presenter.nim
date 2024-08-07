import std/asyncdispatch
import std/sequtils
import basolato/view
import ../../consts
import ../../di_container
import ../../models/dto/article_list/tag_feed_article_list_query_interface
import ../../models/dto/article_list/tag_feed_article_count_query_interface
import ../../models/dto/article_list/article_list_dto
import ../../http/views/templates/feed/feed_template_model
import ../../http/views/components/feed_article/feed_article_component_model
import ../../http/views/components/paginator/paginator_component_model


type TagFeedPresenter* = object
  articleListQuery: ITagFeedArticleListQuery
  articleCountQuery: ITagFeedArticleCountQuery

proc new*(_:type TagFeedPresenter):TagFeedPresenter =
  return TagFeedPresenter(
    articleListQuery: di.tagFeedArticleListQuery,
    articleCountQuery: di.tagFeedArticleCountQuery
  )


proc invoke*(self: TagFeedPresenter):Future[FeedTemplateModel] {.async.} =
  let context = context()
  let isLogin = context.isLogin().await
  let loginUserId = context.get("user_id").await
  let tagId = context.params.getStr("tag")
  let page = context.params.getInt("page", 1)
  let offset = (page - 1) * FEED_DISPLAY_COUNT

  let articleDtoList = self.articleListQuery.invoke(tagId, offset, FEED_DISPLAY_COUNT).await

  let articleList = articleDtoList.map(
    proc(article:ArticleDto):FeedArticleComponentModel =
      let tagList = article.tagList.map(
        proc(tag:TagDto):string =
          tag.name
      )

      let isLoginUserLiked = article.popularUserIdList.contains(loginUserId)

      return FeedArticleComponentModel.new(
        articleId = article.id,
        title = article.title,
        description = article.description,
        createdAt = article.createdAt,
        authorId = article.author.id,
        authorName = article.author.name,
        authorImage = article.author.image,
        popularCount = article.popularUserIdList.len,
        isLoginUserLiked = isLoginUserLiked,
        tagList = tagList,
      )
  )

  let totalCount = self.articleCountQuery.invoke(tagId).await

  let paginatorModel = PaginatorComponentModel.new(
    currentPage = page,
    total = totalCount,
  )

  let model = FeedTemplateModel.new(
    articleList = articleList,
    paginatorModel = paginatorModel,
    feedType = FeedType.tag,
    tagName = tagId
  )
  .await

  return model
