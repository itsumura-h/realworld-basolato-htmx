import basolato/view


type FeedArticleComponentModel* = object
  articleId*:string
  image*:string
  authorId*:string
  authorName*:string
  createdAt*:string
  title*:string
  description*:string
  likes*:int
  isLoginUserLiked*:bool
  tagList*:seq[string]

proc new*(
  _:type FeedArticleComponentModel,
  articleId:string,
  image:string,
  authorId:string,
  authorName:string,
  createdAt:string,
  title:string,
  description:string,
  likes:int,
  isLoginUserLiked:bool,
  tagList:seq[string]
):FeedArticleComponentModel = 
  return FeedArticleComponentModel(
    articleId:articleId,
    image:image,
    authorId:authorId,
    authorName:authorName,
    createdAt:createdAt,
    title:title,
    description:description,
    likes:likes,
    isLoginUserLiked:isLoginUserLiked,
    tagList:tagList
  )
