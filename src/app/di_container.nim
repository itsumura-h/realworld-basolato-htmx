import ./env
# ==================== write ====================
# user
import ./models/aggregates/user/user_repository_interface
import ./data_stores/repositories/user/user_repository
import ./data_stores/repositories/user/mock_user_repository
# article
import ./models/aggregates/article/article_repository_interface
import ./data_stores/repositories/article/mock_article_repository
import ./data_stores/repositories/article/article_repository
# follow relationship
import ./models/aggregates/follow_relationship/follow_relationship_repository_interface
import ./data_stores/repositories/follow_relationship/follow_relationship_repository
import ./data_stores/repositories/follow_relationship/mock_follow_relationship_repository
# favorite
import ./models/aggregates/favorite/favorite_repository_interface
import ./data_stores/repositories/favorite/favorite_repository
import ./data_stores/repositories/favorite/mock_favorite_repository
# ==================== read ====================
import ./models/dto/user/user_query_interface
import ./data_stores/queries/user/user_query
import ./data_stores/queries/user/mock_user_query
#
import ./models/dto/article_with_author/global_feed_article_list_query_interface
import ./data_stores/queries/global_feed_article_list/global_feed_article_list_query
import ./data_stores/queries/global_feed_article_list/mock_global_feed_article_list_query
#
import ./models/dto/paginator/global_feed_article_list_paginator_query_interface
import ./data_stores/queries/global_feed_paginator/global_feed_paginator_query
import ./data_stores/queries/global_feed_paginator/mock_global_feed_paginator_query
#
import ./models/dto/article_with_author/your_feed_article_list_query_interface
import ./data_stores/queries/your_feed_article_list/your_feed_article_list_query
import ./data_stores/queries/your_feed_article_list/mock_your_feed_article_list_query
#
import ./models/dto/paginator/your_feed_article_list_paginator_query_interface
import ./data_stores/queries/your_feed_paginator/your_feed_paginator_query
import ./data_stores/queries/your_feed_paginator/mock_your_feed_paginator_query
#
import ./models/dto/favorite_button/favorite_button_query_interface
import ./data_stores/queries/favorite_button/favorite_button_query
import ./data_stores/queries/favorite_button/mock_favorite_button_query
#
import ./models/dto/tag/tag_list_query_interface
import ./data_stores/queries/popular_tag_list/popular_tag_list_query
import ./data_stores/queries/popular_tag_list/mock_popular_tag_list_query
#
import ./models/dto/article_with_author/user_article_list_query_interface
import ./data_stores/queries/user_article_list/user_article_list_query
import ./data_stores/queries/user_article_list/mock_user_article_list_query
#
import ./models/dto/paginator/user_article_list_paginator_query_interface
import ./data_stores/queries/user_paginator/user_paginator_query
import ./data_stores/queries/user_paginator/mock_user_paginator_query
#
import ./models/dto/follow_button_in_user/follow_button_in_user_query_interface
import ./data_stores/queries/follow_button_in_user/follow_button_in_user_query
import ./data_stores/queries/follow_button_in_user/mock_follow_button_in_user_query


type DiContainer* = object
  # ==================== write ====================
  userRepository*: IUserRepository
  articleRepository*: IArticleRepository
  followRelationshipRepository*: IFollowRelationshipRepository
  favoriteRepository*: IFavoriteRepository
# ==================== read ====================
  userQuery*: IUserQuery
  globalFeedArticleListQuery*: IGlobalFeedArticleListQuery
  globalFeedPaginatorQuery*: IGlobalFeedArticleListPaginatorQuery
  yourFeedArticleListQuery*: IYourFeedArticleListQuery
  yourFeedPaginatorQuery*: IYourFeedArticleListPaginatorQuery
  favoriteButtonQuery*: IFavoriteButtonQuery
  tagListQuery*: ITagListQuery
  userArticleListQuery*: IUserArticleListQuery
  userArticleListPaginatorQuery*: IUserArticleListPaginatorQuery
  followButtonInUserQuery*:IFollowButtonInUserQuery


proc new(_:type DiContainer):DiContainer =
  if APP_ENV == "test":
    return DiContainer(
      # ==================== write ====================
      userRepository: MockUserRepository.new(),
      articleRepository: MockArticleRepository.new(),
      followRelationshipRepository: MockFollowRelationshipRepository.new(),
      favoriteRepository: MockFavoriteRepository.new(),
      # ==================== read ====================
      userQuery: MockUserQuery.new(),
      globalFeedArticleListQuery: MockGlobalFeedArticleListQuery.new(),
      globalFeedPaginatorQuery: MockGlobalFeedPaginatorQuery.new(),
      yourFeedArticleListQuery: MockYourFeedArticleListQuery.new(),
      yourFeedPaginatorQuery: MockYourFeedPaginatorQuery.new(),
      favoriteButtonQuery: MockFavoriteButtonQuery.new(),
      tagListQuery: MockPopularTagListQuery.new(),
      userArticleListQuery: MockUserArticleListQuery.new(),
      userArticleListPaginatorQuery: MockUserPaginatorQuery.new(),
      followButtonInUserQuery: MockFollowButtonInUserQuery.new(),
    )
  else:
    return DiContainer(
      # ==================== write ====================
      userRepository: UserRepository.new(),
      # articleRepository: MockArticleRepository.new(),
      articleRepository: ArticleRepository.new(),
      # ArticleInFeedQuery: MockArticleInFeedQuery.new(),
      followRelationshipRepository: FollowRelationshipRepository.new(),
      # followRelationshipRepository: MockFollowRelationshipRepository.new(),
      favoriteRepository: FavoriteRepository.new(),
      # favoriteRepository: MockFavoriteRepository.new(),
      # ==================== read ====================
      userQuery: UserQuery.new(),
      globalFeedArticleListQuery: GlobalFeedArticleListQuery.new(),
      globalFeedPaginatorQuery: GlobalFeedPaginatorQuery.new(),
      yourFeedArticleListQuery: YourFeedArticleListQuery.new(),
      yourFeedPaginatorQuery: YourFeedPaginatorQuery.new(),
      favoriteButtonQuery: FavoriteButtonQuery.new(),
      tagListQuery: PopularTagListQuery.new(),
      userArticleListQuery: UserArticleListQuery.new(),
      userArticleListPaginatorQuery: UserPaginatorQuery.new(),
      followButtonInUserQuery: FollowButtonInUserQuery.new(),
    )

let di* = DiContainer.new()
