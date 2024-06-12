import std/times
import ../../../../models/dto/comment/comment_dto


type CommentViewModel* = object
  body*:string
  imageUrl*:string
  authorId*:string
  authorName*:string
  createdAt*:string


proc new*(_:type CommentViewModel, dto:CommentDto):CommentViewModel =
  return CommentViewModel(
    body: dto.body,
    imageUrl: dto.user.image,
    authorId: dto.user.id,
    authorName: dto.user.name,
    createdAt: dto.createdAt.format("MMMM ddd"),
  )
