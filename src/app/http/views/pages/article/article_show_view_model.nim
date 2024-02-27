import std/times
import std/options
import std/sequtils
import ../../../../usecases/get_article_in_feed/get_article_in_feed_dto
import ../../components/article/follow_button/follow_button_view_model
import ../../components/article/favorite_button/favorite_button_view_model
import ../../components/article/edit_button/edit_button_view_model
import ../../components/article/delete_button/delete_button_view_model


type Tag*  = object
  tagId*:string
  articleId*:string
  tagName*:string

proc new*(_:type Tag, tagId:string, articleId:string, tagName:string):Tag =
  return Tag(
    tagId:tagId,
    articleId:articleId,
    tagName:tagName
  )


type Article*  = object
  id*:string
  title*:string
  description*:string
  body*:string
  createdAt*:string = "1970 January 1st"
  tags*:seq[Tag]

proc new*(_:type Article, id, title, description, body:string, createdAt:DateTime, tags:seq[Tag]):Article =
  let createdAt = createdAt.format("MMMM d")

  return Article(
    id:id,
    title:title,
    description:description,
    body:body,
    createdAt:createdAt,
    tags:tags,
  )


type User*  = object
  id*:string
  name*:string
  image*:string

proc new*(_:type User, id, name, image:string):User =
  return User(
    id:id,
    name:name,
    image:image,
  )


type ArticleShowViewModel*  = object
  article*:Article
  user*:User
  isAuthor*:bool
  followButtonViewModel*:Option[FollowButtonViewModel]
  favoriteButtonViewModel*:Option[FavoriteButtonViewModel]
  editButtonViewModel*:Option[EditButtonViewModel]
  deleteButtonViewModel*:Option[DeleteButtonViewModel]

proc new*(_:type ArticleShowViewModel, dto:GetArticleInFeedDto, loginUserId:string):ArticleShowViewModel =
  let tags = dto.article.tags.map(
    proc(tag:TagDto):Tag =
      return Tag.new(
        tag.tagId,
        tag.articleId,
        tag.tagName
      )
  )
  let article = Article.new(
    dto.article.id,
    dto.article.title,
    dto.article.description,
    dto.article.body,
    dto.article.createdAt,
    tags,
  )
  let author = User.new(
    dto.user.id,
    dto.user.name,
    dto.user.image,
  )

  let isAuthor = author.id == loginUserId

  let followButtonViewModel = 
    if isAuthor:
      none(FollowButtonViewModel)
    else:
      FollowButtonViewModel.new(
        dto.user.name,
        false,
        dto.user.id == loginUserId,
        dto.user.followerCount,
      )
      .some()

  let favoriteButtonViewModel =
    if isAuthor:
      none(FavoriteButtonViewModel)
    else:
      FavoriteButtonViewModel.new(
        dto.article.isFavorited,
        dto.article.id,
        false,
        dto.article.favoriteCount,
      )
      .some()

  let editButtonViewModel =
    if isAuthor:
      EditButtonViewModel.new(dto.article.id).some()
    else:
      none(EditButtonViewModel)

  let deleteButtonViewModel =
    if isAuthor:
      DeleteButtonViewModel.new(dto.article.id).some()
    else:
      none(DeleteButtonViewModel)

  return ArticleShowViewModel(
    article:article,
    user:author,
    isAuthor:isAuthor,
    followButtonViewModel:followButtonViewModel,
    favoriteButtonViewModel:favoriteButtonViewModel,
    editButtonViewModel: editButtonViewModel,
    deleteButtonViewModel: deleteButtonViewModel,
  )
