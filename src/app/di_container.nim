import ./env
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
# get follow button in user
import ./usecases/get_follow_button_in_user/get_follow_button_in_user_query_interface
import ./data_stores/queries/get_follow_button_in_user/mock_get_follow_button_in_user_query
import ./data_stores/queries/get_follow_button_in_user/get_follow_button_in_user_query
# get article
import ./usecases/get_article_in_feed/get_article_in_feed_query_interface
import ./data_stores/queries/get_article_in_feed/mock_get_article_in_feed_query
import ./data_stores/queries/get_article_in_feed/get_article_in_feed_query
# get comments in article
import ./usecases/get_comments_in_article/get_comments_in_article_query_interface
import ./data_stores/queries/get_comments_in_article/mock_get_comments_in_article_query
import ./data_stores/queries/get_comments_in_article/get_comments_in_article_query
# get user show page
import ./usecases/get_user_show/get_user_show_query_interface
import ./data_stores/queries/get_user_show_query/mock_get_user_show_query
import ./data_stores/queries/get_user_show_query/get_user_show_query
# get articles in user
import ./usecases/get_articles_in_user/get_articles_in_user_query_interface
import ./data_stores/queries/get_articles_in_user/mock_get_articles_in_user_query
import ./data_stores/queries/get_articles_in_user/get_articles_in_user_query
# get favorite articles in user
import ./usecases/get_favorites_in_user/get_favorites_in_user_query_interface
import ./data_stores/queries/get_favorites_in_user/mock_get_favorites_in_user_query
import ./data_stores/queries/get_favorites_in_user/get_favorites_in_user_query
# get your feed
import ./usecases/get_your_feed/get_your_feed_query_interface
import ./data_stores/queries/get_your_feed/mock_get_your_feed_query
import ./data_stores/queries/get_your_feed/get_your_feed_query
# get tag feed
import ./usecases/get_tag_feed/get_tag_feed_query_interface
import ./data_stores/queries/get_tag_feed/mock_get_tag_feed_query
import ./data_stores/queries/get_tag_feed/get_tag_feed_query
# get setting show
import ./usecases/get_login_user/get_login_user_query_interface
import ./data_stores/queries/get_login_user/mock_get_login_user_query
import ./data_stores/queries/get_login_user/get_login_user_query
# get article in editor
import ./usecases/get_article_in_editor/get_article_in_editor_query_interface
import ./data_stores/queries/get_article_in_editor/mock_get_article_in_editor_query
import ./data_stores/queries/get_article_in_editor/get_article_in_editor_query


type DiContainer* = tuple
  userRepository: IUserRepository
  articleRepository: IArticleRepository
  followRelationshipRepository: IFollowRelationshipRepository
  getArticleInFeedQuery: IGetArticleInFeedQuery
  getCommentsInArticleQuery:IGetCommentsInArticleQuery
  getUserShowQuery: IGetUserShowQuery
  getFollowButtonInUserQuery: IGetFollowButtonInUserQuery
  getArticlesInUserQuery: IGetArticlesInUserQuery
  getFavoritesInUserQuery: IGetFavoritesInUserQuery
  getYourFeedQuery: IGetYourFeedQuery
  getTagFeedQuery: IGetTagFeedQuery
  getLoginUserQuery: IGetLoginUserQuery
  getArticleInEditorQuery: IGetArticleInEditorQuery


proc newDiContainer():DiContainer =
  if APP_ENV == "test":
    return (
      userRepository: MockUserRepository.new(),
      articleRepository: MockArticleRepository.new(),
      followRelationshipRepository: MockFollowRelationshipRepository.new(),
      getArticleInFeedQuery: MockGetArticleInFeedQuery.new(),
      getCommentsInArticleQuery:MockGetCommentsInArticleQuery.new(),
      getUserShowQuery: MockGetUserShowQuery.new(),
      getFollowButtonInUserQuery: MockGetFollowButtonInUserQuery.new(),
      getArticlesInUserQuery: MockGetArticlesInUserQuery.new(),
      getFavoritesInUserQuery: MockGetFavoritesInUserQuery.new(),
      getYourFeedQuery: MockGetYourFeedQuery.new(),
      getTagFeedQuery: MockGetTagFeedQuery.new(),
      getLoginUserQuery: MockGetLoginUserQuery.new(),
      getArticleInEditorQuery: MockGetArticleInEditorQuery.new(),
    )
  else:
    return (
      userRepository: UserRepository.new(),
      # articleRepository: MockArticleRepository.new(),
      articleRepository: ArticleRepository.new(),
      # getArticleInFeedQuery: MockGetArticleInFeedQuery.new(),
      followRelationshipRepository: FollowRelationshipRepository.new(),
      # followRelationshipRepository: MockFollowRelationshipRepository.new(),
      getArticleInFeedQuery: GetArticleInFeedQuery.new(),
      # getCommentsInArticleQuery:MockGetCommentsInArticleQuery.new(),
      getCommentsInArticleQuery:GetCommentsInArticleQuery.new(),
      # getUserShowQuery: MockGetUserShowQuery.new(),
      getUserShowQuery: GetUserShowQuery.new(),
      # getFollowButtonInUserQuery: MockGetFollowButtonInUserQuery.new(),
      getFollowButtonInUserQuery: GetFollowButtonInUserQuery.new(),
      # getArticlesInUserQuery: MockGetArticlesInUserQuery.new(),
      getArticlesInUserQuery: GetArticlesInUserQuery.new(),
      # getFavoritesInUserQuery: MockGetFavoritesInUserQuery.new(),
      getFavoritesInUserQuery: GetFavoritesInUserQuery.new(),
      # getYourFeedQuery: MockGetYourFeedQuery.new(),
      getYourFeedQuery: GetYourFeedQuery.new(),
      # getTagFeedQuery: MockGetTagFeedQuery.new(),
      getTagFeedQuery: GetTagFeedQuery.new(),
      # getLoginUserQuery: MockGetLoginUserQuery.new(),
      getLoginUserQuery: GetLoginUserQuery.new(),
      # getArticleInEditorQuery: MockGetArticleInEditorQuery.new(),
      getArticleInEditorQuery: GetArticleInEditorQuery.new(),
    )

let di* = newDiContainer()
