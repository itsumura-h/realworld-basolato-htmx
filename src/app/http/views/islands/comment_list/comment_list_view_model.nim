import ../../components/comment/comment_view_model


type CommentListViewModel* = object
  isLogin*:bool
  commentList*:seq[CommentViewModel]

proc new*(_:type CommentListViewModel, isLogin:bool, commentList:seq[CommentViewModel]): CommentListViewModel =
  return CommentListViewModel(
    isLogin:isLogin,
    commentList:commentList
  )
