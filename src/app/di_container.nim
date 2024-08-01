import ./env
# ==================== write ====================
import ./models/aggregates/user/user_repository_interface
import ./data_stores/repositories/user/user_repository
import ./data_stores/repositories/user/mock_user_repository

# ==================== read ====================
import ./models/dto/user/user_query_interface
import ./data_stores/queries/user/user_query
import ./data_stores/queries/user/mock_user_query

import ./models/dto/article_list/global_feed_article_list_query_interface
import ./data_stores/queries/article_list/global_feed/global_feed_article_list_query
import ./data_stores/queries/article_list/global_feed/mock_global_feed_article_list_query

type DiContainer* = object
# ==================== write ====================
  userRepository*: IUserRepository
# ==================== read ====================
  userQuery*: IUserQuery
  globalFeedArticleListQuery*: IGlobalFeedArticleListQuery


proc new(_:type DiContainer):DiContainer =
  if APP_ENV == "test":
    return DiContainer(
      # ==================== write ====================
      userRepository: MockUserRepository.new(),
      # ==================== read ====================
      userQuery: MockUserQuery.new(),
      globalFeedArticleListQuery: MockGlobalFeedArticleListQuery.new(),
    )
  else:
    return DiContainer(
      # ==================== write ====================
      userRepository: UserRepository.new(),
      # ==================== read ====================
      userQuery: UserQuery.new(),
      globalFeedArticleListQuery: GlobalFeedArticleListQuery.new(),
    )

let di* = DiContainer.new()
