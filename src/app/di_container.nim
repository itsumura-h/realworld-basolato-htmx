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
import ./usecases/get_article/get_article_query_interface
import ./data_stores/queries/get_article/mock_get_article_query
import ./data_stores/queries/get_article/get_article_query
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
  getArticleQuery: IGetArticleQuery
  getCommentsInArticleQuery:IGetCommentsInArticleQuery
  getUserShowQuery: IGetUserShowQuery
  getArticlesInUserQuery: IGetArticlesInUserQuery
  getFavoritesInUserQuery: IGetFavoritesInUserQuery
  getTagFeedQuery: IGetTagFeedQuery
  getLoginUserQuery: IGetLoginUserQuery


proc newDiContainer():DiContainer =
  if APP_ENV == "test":
    return (
      userRepository: MockUserRepository.new(),
      articleRepository: MockArticleRepository.new(),
      getArticleQuery: MockGetArticleQuery.new(),
      getCommentsInArticleQuery:MockGetCommentsInArticleQuery.new(),
      getUserShowQuery: MockGetUserShowQuery.new(),
      getArticlesInUserQuery: MockGetArticlesInUserQuery.new(),
      getFavoritesInUserQuery: MockGetFavoritesInUserQuery.new(),
      getTagFeedQuery: MockGetTagFeedQuery.new(),
      getLoginUserQuery: MockGetLoginUserQuery.new(),
    )
  else:
    return (
      userRepository: UserRepository.new(),
      articleRepository: MockArticleRepository.new(),
      # articleRepository: ArticleRepository.new(),
      # getArticleQuery: MockGetArticleQuery.new(),
      getArticleQuery: GetArticleQuery.new(),
      # getCommentsInArticleQuery:MockGetCommentsInArticleQuery.new(),
      getCommentsInArticleQuery:GetCommentsInArticleQuery.new(),
      # getUserShowQuery: MockGetUserShowQuery.new(),
      getUserShowQuery: GetUserShowQuery.new(),
      # getArticlesInUserQuery: MockGetArticlesInUserQuery.new(),
      getArticlesInUserQuery: GetArticlesInUserQuery.new(),
      # getFavoritesInUserQuery: MockGetFavoritesInUserQuery.new(),
      getFavoritesInUserQuery: GetFavoritesInUserQuery.new(),
      # getTagFeedQuery: MockGetTagFeedQuery.new(),
      getTagFeedQuery: GetTagFeedQuery.new(),
      # getLoginUserQuery: MockGetLoginUserQuery.new(),
      getLoginUserQuery: GetLoginUserQuery.new(),
    )

let di* = newDiContainer()
