import std/asyncdispatch
import basolato/view
import ../../components/comment/comment_component_model
import ../../../../models/dto/user/user_query_interface
import ../../../../models/dto/article_detail/article_detail_query_interface
import ../../../../models/dto/tag/tag_query_interface
import ../../../../di_container


type Author* = object
  image*:string
  name*:string
  id*:string
  followerCount*:int
  isAuthor*:bool
  tagList*:seq[string]


type Article* = object
  title*:string
  content*:string
  favoriteCount*:int
  updatedAt*:string
  tagList*:seq[string]


type ArticleTemplateModel* = object
  author*:Author
  article*:Article
  isAuthor*:bool
  commentList*:seq[CommentComponentModel]


proc new*(_: type ArticleTemplateModel):Future[ArticleTemplateModel] {.async.} =
  let context = context()
  let articleId = context.params.get("articleId")

  let userQuery:IUserQuery = di.userQuery
  let articleDetailQuery:IArticleDetailQuery = di.articleDetailQuery

  let articleData = articleDetailQuery.getArticleById(articleId).await
  echo "articleData: ",articleData

  let author = Author(
    image: "http://i.imgur.com/Qr71crq.jpg",
    name: "Eric Simons",
    id: "eric-simons",
    followerCount: 10,
    isAuthor: true,
    tagList: @["tag1", "tag2", "tag3"],
  )

  let article = Article(
    title: "title",
    content: "content",
    favoriteCount: 29,
    updatedAt: "January 20th",
    tagList: @["tag1", "tag2", "tag3"],
  )

  let commentList = @[
    CommentComponentModel(
      authorId: "1",
      authorName: "authorName1",
      authorImage: "http://i.imgur.com/Qr71crq.jpg",
      content: "content1",
      createdAt: "2021-01-01",
      isAuthor: true,
    ),
    CommentComponentModel(
      authorId: "2",
      authorName: "authorName2",
      authorImage: "http://i.imgur.com/Qr71crq.jpg",
      content: "content2",
      createdAt: "2021-01-01",
      isAuthor: true,
    ),
  ]

  return ArticleTemplateModel(
    author: author,
    article: article,
    isAuthor: true,
    commentList: commentList,
  )
