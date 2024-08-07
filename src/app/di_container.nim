import ./consts
# ==================== write ====================
import ./models/aggregates/user/user_repository_interface
import ./data_stores/repositories/user/user_repository
import ./data_stores/repositories/user/mock_user_repository

# ==================== read ====================
import ./models/dto/user/user_query_interface
import ./data_stores/queries/user/user_query
import ./data_stores/queries/user/mock_user_query
# global feed list
import ./models/dto/article_list/global_feed_article_list_query_interface
import ./data_stores/queries/article_list/global_feed_article_list/global_feed_article_list_query
import ./data_stores/queries/article_list/global_feed_article_list/mock_global_feed_article_list_query
# global feed count
import ./models/dto/article_list/global_feed_article_count_query_interface
import ./data_stores/queries/article_list/global_feed_article_count/global_feed_article_count_query
import ./data_stores/queries/article_list/global_feed_article_count/mock_global_feed_article_count_query
# tag feed list
import ./models/dto/article_list/tag_feed_article_list_query_interface
import ./data_stores/queries/article_list/tag_feed_article_list/tag_feed_article_list_query
import ./data_stores/queries/article_list/tag_feed_article_list/mock_tag_feed_article_list_query
# tag feed count
import ./models/dto/article_list/tag_feed_article_count_query_interface
import ./data_stores/queries/article_list/tag_feed_article_count/tag_feed_article_count_query
import ./data_stores/queries/article_list/tag_feed_article_count/mock_tag_feed_article_count_query


import ./models/dto/tag/polutar_tag_list_query_interface
import ./data_stores/queries/tag/popular_tag_list/popular_tag_list_query
import ./data_stores/queries/tag/popular_tag_list/mock_popular_tag_list_query

type DiContainer* = object
# ==================== write ====================
  userRepository*: IUserRepository
# ==================== read ====================
  userQuery*: IUserQuery
  globalFeedArticleListQuery*: IGlobalFeedArticleListQuery
  globalFeedArticleCountQuery*: IGlobalFeedArticleCountQuery
  tagFeedArticleListQuery*: ITagFeedArticleListQuery
  tagFeedArticleCountQuery*: ITagFeedArticleCountQuery
  popularTagListQuery*: IPopularTagListQuery

proc new(_:type DiContainer):DiContainer =
  if APP_ENV == "test":
    return DiContainer(
      # ==================== write ====================
      userRepository: MockUserRepository.new(),
      # ==================== read ====================
      userQuery: MockUserQuery.new(),
      globalFeedArticleListQuery: MockGlobalFeedArticleListQuery.new(),
      globalFeedArticleCountQuery: MockGlobalFeedArticleCountQuery.new(),
      tagFeedArticleListQuery: MockTagFeedArticleListQuery.new(),
      tagFeedArticleCountQuery: MockTagFeedArticleCountQuery.new(),
      popularTagListQuery: MockPopularTagListQuery.new(),
    )
  else:
    return DiContainer(
      # ==================== write ====================
      userRepository: UserRepository.new(),
      # ==================== read ====================
      userQuery: UserQuery.new(),
      globalFeedArticleListQuery: GlobalFeedArticleListQuery.new(),
      globalFeedArticleCountQuery: GlobalFeedArticleCountQuery.new(),
      tagFeedArticleListQuery: TagFeedArticleListQuery.new(),
      tagFeedArticleCountQuery: TagFeedArticleCountQuery.new(),
      popularTagListQuery: PopularTagListQuery.new(),
    )

let di* = DiContainer.new()
