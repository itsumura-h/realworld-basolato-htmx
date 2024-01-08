import ./env
# user
import ./models/aggregates/user/creating_user/creating_user_repository_interface
import ./data_stores/repositories/user/creating_user/creating_user_repository
import ./data_stores/repositories/user/creating_user/mock_creating_user_repository
# article
import ./usecases/article/article_query_interface
import ./data_stores/queries/article_query
import ./data_stores/queries/mock_article_query


type DiContainer* = tuple
  userRepository: ICreatingUserRepository
  articleQuery:IArticleQuery


proc newDiContainer():DiContainer =
  if APP_ENV == "test":
    return (
      userRepository: MockCreatingUserRepository.new().toInterface(),
      articleQuery: MockArticleQuery.new().toInterface(),
    )
  else:
    return (
      userRepository: CreatingUserRepository.new().toInterface(),
      articleQuery: ArticleQuery.new().toInterface(),
    )

let di* = newDiContainer()
