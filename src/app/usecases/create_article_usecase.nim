import std/asyncdispatch
import ../models/aggregates/article/article_entity
import ../models/aggregates/user/vo/user_id
import ../models/aggregates/article/vo/article_id
import ../models/aggregates/article/vo/title
import ../models/aggregates/article/vo/description
import ../models/aggregates/article/vo/body
import ../models/aggregates/article/article_repository_interface
import ../di_container


type CreateArticleUsecase* = object
  repository:IArticleRepository


proc new*(_:type CreateArticleUsecase):CreateArticleUsecase =
  return CreateArticleUsecase(
    repository:di.articleRepository
  )
  


proc invoke*(self:CreateArticleUsecase, userId, title, description, body:string) {.async.} =
  let title = Title.new(title)
  let description = Description.new(description)
  let body = Body.new(body)
  let userId = UserId.new(userId)
  let article = DraftArticle.new(title, description, body, userId)
  self.repository.create(article).await
