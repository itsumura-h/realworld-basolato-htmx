import std/asyncdispatch
import std/times
import std/sequtils
import basolato/view
import markdown
import ../../components/comment/comment_component_model
import ../../../../models/dto/user/user_dao_interface
import ../../../../models/dto/article_detail/article_detail_dao_interface
import ../../../../models/dto/comment/comment_dao_interface
import ../../../../models/dto/comment/comment_dto
import ../../../../di_container


type Author* = object
  id*:string
  image*:string
  name*:string
  followerCount*:int

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
  isLogin*:bool


proc new*(_: type ArticleTemplateModel):Future[ArticleTemplateModel] {.async.} =
  let context = context()
  let articleId = context.params.getStr("articleId")
  let loginUserId = context.get("user_id").await
  let isLogin = context.isLogin().await

  let articleDetailDao:IArticleDetailDao = di.articleDetailDao
  let articleDeatailDto = articleDetailDao.getArticleById(articleId).await

  let userDao:IUserDao = di.userDao
  let authorDto = userDao.getUserById(articleDeatailDto.authorId).await

  let author = Author(
    id: authorDto.id,
    image: authorDto.image,
    name: authorDto.name,
    followerCount: authorDto.followerCount,
  )

  let article = Article(
    title: articleDeatailDto.title,
    content: articleDeatailDto.content.markdown(),
    favoriteCount: articleDeatailDto.favoriteCount,
    updatedAt: articleDeatailDto.updatedAt.format("yyyy MMM d"),
  )

  let isAuthor = loginUserId == articleDeatailDto.authorId

  return ArticleTemplateModel(
    author: author,
    article: article,
    isAuthor: isAuthor,
    isLogin: isLogin,
  )
