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
# get articles in user
import ./usecases/get_user_show/get_user_show_query_interface
import ./data_stores/queries/get_user_show_query/get_user_show_query
import ./data_stores/queries/get_user_show_query/mock_get_user_show_query


type DiContainer* = tuple
  userRepository: IUserRepository
  articleRepository: IArticleRepository
  getArticleQuery: IGetArticleQuery
  getCommentsInArticleQuery:IGetCommentsInArticleQuery
  getArticlesInUserQuery: IGetUserShowQuery


proc newDiContainer():DiContainer =
  if APP_ENV == "test":
    return (
      userRepository: MockUserRepository.new(),
      articleRepository: MockArticleRepository.new(),
      getArticleQuery: MockGetArticleQuery.new(),
      getCommentsInArticleQuery:MockGetCommentsInArticleQuery.new(),
      getArticlesInUserQuery: MockGetUserShowQuery.new(),
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
      # getArticlesInUserQuery: MockGetUserShowQuery.new(),
      getArticlesInUserQuery: GetUserShowQuery.new(),
    )

let di* = newDiContainer()
