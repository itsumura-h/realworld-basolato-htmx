import ../../components/article_preview/article_preview_view_model
import ../../components/feed_navbar/feed_navbar_view_model
import ../../components/paginator/paginator_view_model


type FeedViewModel* = object
  articlePreviewViewModelList*: seq[ArticlePreviewViewModel]
  paginatorViewModel*:PaginatorViewModel
  feedNavbarViewModel*:FeedNavbarViewModel

proc new*(
  _:type FeedViewModel,
  articlePreviewViewModelList:seq[ArticlePreviewViewModel],
  paginatorViewModel:PaginatorViewModel,
  feedNavbarViewModel:FeedNavbarViewModel
):FeedViewModel =
  return FeedViewModel(
    articlePreviewViewModelList:articlePreviewViewModelList,
    paginatorViewModel:paginatorViewModel,
    feedNavbarViewModel:feedNavbarViewModel
  )
