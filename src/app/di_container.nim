import ./env
# user
import ./models/aggregates/user/creating_user/creating_user_repository_interface
import ./data_stores/repositories/user/creating_user/creating_user_repository
import ./data_stores/repositories/user/creating_user/mock_creating_user_repository
# get article
import ./usecases/get_article/get_article_query_interface
import ./data_stores/queries/get_article/mock_get_article_query
import ./data_stores/queries/get_article/get_article_query
# get comments in article
import ./usecases/get_comments_in_article/get_comments_in_article_query_interface
import ./data_stores/queries/get_comments_in_article/mock_get_comments_in_article_query
import ./data_stores/queries/get_comments_in_article/get_comments_in_article_query


type DiContainer* = tuple
  userRepository: ICreatingUserRepository
  getArticleQuery: IGetArticleQuery
  getCommentsInArticleQuery:IGetCommentsInArticleQuery


proc newDiContainer():DiContainer =
  if APP_ENV == "test":
    return (
      userRepository: MockCreatingUserRepository.new().toInterface(),
      getArticleQuery: MockGetArticleQuery.new(),
      getCommentsInArticleQuery:MockGetCommentsInArticleQuery.new(),
    )
  else:
    return (
      userRepository: CreatingUserRepository.new().toInterface(),
      # getArticleQuery: MockGetArticleQuery.new(),
      getArticleQuery: GetArticleQuery.new(),
      # getCommentsInArticleQuery:MockGetCommentsInArticleQuery.new(),
      getCommentsInArticleQuery:GetCommentsInArticleQuery.new(),
    )

let di* = newDiContainer()
