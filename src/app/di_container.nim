import ./env
# user
import ./models/aggregates/user/creating_user/creating_user_repository_interface
import ./data_stores/repositories/user/creating_user/creating_user_repository
import ./data_stores/repositories/user/creating_user/mock_creating_user_repository
# get_comments_in_article
import ./usecases/get_comments_in_article/get_comments_in_article_query_interface
import ./data_stores/queries/get_comments_in_article/mock_get_comments_in_article_query
import ./data_stores/queries/get_comments_in_article/get_comments_in_article_query


type DiContainer* = tuple
  userRepository: ICreatingUserRepository
  getCommentsInArticleQuery:IGetCommentsInArticleQuery


proc newDiContainer():DiContainer =
  if APP_ENV == "test":
    return (
      userRepository: MockCreatingUserRepository.new().toInterface(),
      getCommentsInArticleQuery:MockGetCommentsInArticleQuery.new(),
    )
  else:
    return (
      userRepository: CreatingUserRepository.new().toInterface(),
      getCommentsInArticleQuery:GetCommentsInArticleQuery.new(),
      # getCommentsInArticleQuery:MockGetCommentsInArticleQuery.new(),
    )

let di* = newDiContainer()
