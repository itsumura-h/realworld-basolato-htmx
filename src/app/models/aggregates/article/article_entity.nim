import std/times
import ./vo/article_id
import ./vo/title
import ./vo/description
import ./vo/body
import ../user/vo/user_id


type DraftArticle* = object
  articleId*: ArticleId
  title*: Title
  description*: Description
  body*: Body
  userId*: UserId
  createdAt*:DateTime
  updatedAt*:DateTime


proc init*(_:type DraftArticle,
  title:Title,
  description:Description,
  body:Body,
  userId:UserId
): DraftArticle =
  let articleId = ArticleId.init(title)
  let now = now().utc()
  return DraftArticle(
    articleId: articleId,
    title: title,
    description:description,
    body: body,
    createdAt: now,
    updatedAt: now,
  )
