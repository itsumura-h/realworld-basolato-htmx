import std/asyncdispatch
import std/sequtils
import ../models/aggregates/article/article_entity
import ../models/aggregates/user/vo/user_id
import ../models/aggregates/article/vo/article_id
import ../models/aggregates/article/vo/title
import ../models/aggregates/article/vo/description
import ../models/aggregates/article/vo/body
import ../models/aggregates/article/tag_entity
import ../models/aggregates/article/vo/tag_name
import ../models/aggregates/article/article_repository_interface
import ../di_container


type UpdateArticleUsecase* = object
  repository:IArticleRepository


proc new*(_:type UpdateArticleUsecase):UpdateArticleUsecase =
  return UpdateArticleUsecase(
    repository:di.articleRepository
  )


proc invoke*(self:UpdateArticleUsecase, userId, articleId, title, description, body:string, tags:seq[string])  {.async.} =
  let articleId = ArticleId.new(articleId)
  let title = Title.new(title)
  let description = Description.new(description)
  let body = Body.new(body)
  let userId = UserId.new(userId)
  let tags = tags.map(
    proc(tagName:string):Tag =
      return Tag.new(tagName)
  )
  let article = Article.new(articleId, title, description, body, tags, userId)
  self.repository.update(article).await
