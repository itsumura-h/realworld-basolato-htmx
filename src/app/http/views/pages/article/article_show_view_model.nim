import std/times
import std/sequtils
import ../../../../usecases/get_article/get_article_dto
import ../../components/article/follow_button/follow_button_view_model
import ../../components/article/favorite_button/favorite_button_view_model


type Tag* = object
  tagId*:int
  articleId*:string
  tagName*:string

proc init*(_:type Tag, tagId:int, articleId:string, tagName:string):Tag =
  return Tag(
    tagId:tagId,
    articleId:articleId,
    tagName:tagName
  )


type Article* = object
  id*:string
  title*:string
  description*:string
  body*:string
  createdAt*:string = "1970 January 1st"
  tags*:seq[Tag]

proc init*(_:type Article, id, title, description, body:string, createdAt:DateTime, tags:seq[Tag]):Article =
  let createdAt = createdAt.format("MMMM d")

  return Article(
    id:id,
    title:title,
    description:description,
    body:body,
    createdAt:createdAt,
    tags:tags,
  )


type User* = object
  id*:string
  name*:string
  image*:string

proc init*(_:type User, id, name, image:string):User =
  return User(
    id:id,
    name:name,
    image:image,
  )


type ArticleShowViewModel* = object
  article*:Article
  user*:User
  followButtonViewModel*:FollowButtonViewModel
  favoriteButtonViewModel*:FavoriteButtonViewModel

proc init*(_:type ArticleShowViewModel, dto:GetArticleDto, loginUserId:string):ArticleShowViewModel =
  let tags = dto.article.tags.map(
    proc(tag:TagDto):Tag =
      return Tag.init(
        tag.tagId,
        tag.articleId,
        tag.tagName
      )
  )
  let article = Article.init(
    dto.article.id,
    dto.article.title,
    dto.article.description,
    dto.article.body,
    dto.article.createdAt,
    tags,
  )
  let author = User.init(
    dto.user.id,
    dto.user.name,
    dto.user.image,
  )

  let followButtonViewModel = FollowButtonViewModel.init(
    dto.user.name,
    false,
    dto.user.id == loginUserId,
    dto.user.followerCount,
  )

  let favoriteButtonViewModel = FavoriteButtonViewModel.init(
    dto.article.isFavorited,
    dto.article.id,
    false,
    dto.article.favoriteCount,
  )

  return ArticleShowViewModel(
    article:article,
    user:author,
    followButtonViewModel:followButtonViewModel,
    favoriteButtonViewModel:favoriteButtonViewModel,
  )
