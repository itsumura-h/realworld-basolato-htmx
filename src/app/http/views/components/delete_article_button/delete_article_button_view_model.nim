type DeleteArticleButtonViewModel* = object
  articleId*:string

proc new*(_:type DeleteArticleButtonViewModel, articleId:string): DeleteArticleButtonViewModel =
  return DeleteArticleButtonViewModel(articleId: articleId)
