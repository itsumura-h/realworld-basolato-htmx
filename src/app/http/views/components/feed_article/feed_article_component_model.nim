import std/times
import basolato/view
import ../../../../models/dto/article/article_dto


type FeedArticleComponentModel* = object
  articleId*:string
  title*:string
  description*:string
  createdAt*:string
  authorId*:string
  authorName*:string
  authorImage*:string
  likes*:int
  isLoginUserLiked*:bool
  tagList*:seq[string]

proc new*(
  _:type FeedArticleComponentModel,
  articleId:string,
  title:string,
  description:string,
  createdAt:DateTime,
  authorId:string,
  authorName:string,
  authorImage:string,
  likes:int,
  isLoginUserLiked:bool,
  tagList:seq[string]
):FeedArticleComponentModel = 
  return FeedArticleComponentModel(
    articleId:articleId,
    title:title,
    description:description,
    createdAt:createdAt.format("yyyy MMMM d"),
    authorId:authorId,
    authorName:authorName,
    authorImage:authorImage,
    likes:likes,
    isLoginUserLiked:isLoginUserLiked,
    tagList:tagList
  )
