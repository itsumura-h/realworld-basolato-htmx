import std/times
import std/options
import std/sequtils
import markdown
import ../../../../models/dto/article_detail/article_detail_dto
import ../../../../models/dto/favorite_button/favorite_button_dto
import ../../../../models/dto/follow_button/follow_button_dto
import ../../../../models/dto/comment/comment_dto
import ../../../../models/vo/user_id
import ../../islands/detail_favorite_button/detail_favorite_button_view_model
import ../../islands/detail_follow_button/detail_follow_button_view_model
import ../../islands/comment_list/comment_list_view_model
import ../../components/comment/comment_view_model
import ../../components/edit_article_button/edit_article_button_view_model
import ../../components/delete_article_button/delete_article_button_view_model


type Tag*  = object
  id*:string
  name*:string

proc new*(_:type Tag, id:string, name:string):Tag =
  return Tag(
    id:id,
    name:name
  )


type Article*  = object
  id*:string
  title*:string
  description*:string
  body*:string
  createdAt*:string = "1970 January 1st"
  tagList*:seq[Tag]

proc new*(_:type Article, dto:ArticleDetailDto):Article =
  let tagList = dto.tagList.map(
    proc(tag:TagDto):Tag =
      return Tag.new(
        tag.id,
        tag.name
      )
  )

  let createdAt = dto.createdAt.format("MMMM d")

  return Article(
    id: dto.id,
    title: dto.title,
    description: markdown(dto.description),
    body: dto.body,
    createdAt: createdAt,
    tagList: tagList,
  )


type Author*  = object
  id*:string
  name*:string
  image*:string

proc new*(_:type Author, dto:AuthorDto):Author =
  return Author(
    id:dto.id,
    name:dto.name,
    image:dto.image,
  )


type ArticleViewModel*  = object
  article*:Article
  author*:Author
  isAuthor*:bool
  followButtonViewModel*:Option[DetailFollowButtonViewModel]
  favoriteButtonViewModel*:Option[DetailFavoriteButtonViewModel]
  editButtonViewModel*:Option[EditArticleButtonViewModel]
  deleteButtonViewModel*:Option[DeleteArticleButtonViewModel]
  commentListViewModel*:CommentListViewModel

proc new*(
  _:type ArticleViewModel,
  articleDto:ArticleDetailDto,
  favoriteButtonDto: FavoriteButtonDto,
  followButtonDto: FollowButtonDto,
  commnetDtoList:seq[CommentDto],
  loginUserId:Option[UserId],
):ArticleViewModel =
  let article = Article.new(articleDto)

  let author = Author.new(articleDto.author)

  let isAuthor = (loginUserId.isSome()) and (author.id == loginUserId.get().value)

  let favoriteButtonViewModel =
    if isAuthor:
      none(DetailFavoriteButtonViewModel)
    else:
      DetailFavoriteButtonViewModel.new(favoriteButtonDto).some()

  let followButtonViewModel = 
    if isAuthor:
      none(DetailFollowButtonViewModel)
    else:
      DetailFollowButtonViewModel.new(followButtonDto).some()

  let editButtonViewModel =
    if isAuthor:
      EditArticleButtonViewModel.new(articleDto.id).some()
    else:
      none(EditArticleButtonViewModel)

  let deleteButtonViewModel =
    if isAuthor:
      DeleteArticleButtonViewModel.new(articleDto.id).some()
    else:
      none(DeleteArticleButtonViewModel)

  let commentViewModelList = commnetDtoList.map(
    proc(commentDto:CommentDto):CommentViewModel =
      return CommentViewModel.new(commentDto)
  )
  let isLogin = loginUserId.isSome()
  let commentListViewModel = CommentListViewModel.new(isLogin, commentViewModelList)

  return ArticleViewModel(
    article:article,
    author:author,
    isAuthor:isAuthor,
    followButtonViewModel:followButtonViewModel,
    favoriteButtonViewModel:favoriteButtonViewModel,
    editButtonViewModel: editButtonViewModel,
    deleteButtonViewModel: deleteButtonViewModel,
    commentListViewModel:commentListViewModel,
  )
