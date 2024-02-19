import ./env
# user
import ./models/aggregates/user/user_repository_interface
import ./data_stores/repositories/user/user_repository
import ./data_stores/repositories/user/mock_user_repository
# article
import ./models/aggregates/article/article_repository_interface
import ./data_stores/repositories/article/mock_article_repository
import ./data_stores/repositories/article/article_repository
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
# get tag feed
import ./usecases/get_tag_feed/get_tag_feed_query_interface
import ./data_stores/queries/get_tag_feed/mock_get_tag_feed_query
import ./data_stores/queries/get_tag_feed/get_tag_feed_query
# get setting show
import ./usecases/get_login_user/get_login_user_query_interface
import ./data_stores/queries/get_login_user/mock_get_login_user_query
import ./data_stores/queries/get_login_user/get_login_user_query


type DiContainer* = tuple
  userRepository: IUserRepository
  articleRepository: IArticleRepository
  getArticleInFeedQuery: IGetArticleInFeedQuery
  getCommentsInArticleQuery:IGetCommentsInArticleQuery
  getUserShowQuery: IGetUserShowQuery
  getArticlesInUserQuery: IGetArticlesInUserQuery
  getFavoritesInUserQuery: IGetFavoritesInUserQuery
  getTagFeedQuery: IGetTagFeedQuery
  getLoginUserQuery: IGetLoginUserQuery


proc newDiContainer():DiContainer =
  if APP_ENV == "test":
    return (
      userRepository: MockUserRepository.init(),
      articleRepository: MockArticleRepository.init(),
      getArticleInFeedQuery: MockGetArticleInFeedQuery.init(),
      getCommentsInArticleQuery:MockGetCommentsInArticleQuery.init(),
      getUserShowQuery: MockGetUserShowQuery.init(),
      getArticlesInUserQuery: MockGetArticlesInUserQuery.init(),
      getFavoritesInUserQuery: MockGetFavoritesInUserQuery.init(),
      getTagFeedQuery: MockGetTagFeedQuery.init(),
      getLoginUserQuery: MockGetLoginUserQuery.init(),
    )
  else:
    return (
      userRepository: UserRepository.init(),
      articleRepository: MockArticleRepository.init(),
      # articleRepository: ArticleRepository.init(),
      # getArticleInFeedQuery: MockGetArticleInFeedQuery.init(),
      getArticleInFeedQuery: GetArticleInFeedQuery.init(),
      # getCommentsInArticleQuery:MockGetCommentsInArticleQuery.init(),
      getCommentsInArticleQuery:GetCommentsInArticleQuery.init(),
      # getUserShowQuery: MockGetUserShowQuery.init(),
      getUserShowQuery: GetUserShowQuery.init(),
      # getArticlesInUserQuery: MockGetArticlesInUserQuery.init(),
      getArticlesInUserQuery: GetArticlesInUserQuery.init(),
      # getFavoritesInUserQuery: MockGetFavoritesInUserQuery.init(),
      getFavoritesInUserQuery: GetFavoritesInUserQuery.init(),
      # getTagFeedQuery: MockGetTagFeedQuery.init(),
      getTagFeedQuery: GetTagFeedQuery.init(),
      # getLoginUserQuery: MockGetLoginUserQuery.init(),
      getLoginUserQuery: GetLoginUserQuery.init(),
    )

let di* = newDiContainer()
