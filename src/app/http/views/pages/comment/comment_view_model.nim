import std/times
import std/sequtils
import ../../../../models/dto/comment_list_in_article/comment_list_in_article_dto
import ./card/card_view_model
import ./form/form_view_model


type CommentViewModel*  = object
  cardList*:seq[CardViewModel]
  form*:FormViewModel
  isLogin*:bool

proc new*(_:type CommentViewModel, dto:CommentListInArticleDto, isLogin:bool):CommentViewModel =
  let cardList = dto.commentList.map(
    proc(row:CommentDto):CardViewModel =
      return CardViewModel.new(
        row.body,
        row.createdAt,
        row.user.id,
        row.user.name,
        row.user.image,
      )
  )
  let form = FormViewModel.new(
    dto.article.id,
    dto.article.user.image,
  )
  return CommentViewModel(
    cardList:cardList,
    form:form,
    isLogin:isLogin
  )
