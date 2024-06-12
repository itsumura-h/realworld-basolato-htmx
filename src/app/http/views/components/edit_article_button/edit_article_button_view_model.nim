type EditArticleButtonViewModel* = object
  articleId*:string

proc new*(_:type EditArticleButtonViewModel, articleId:string): EditArticleButtonViewModel =
  return EditArticleButtonViewModel(articleId: articleId)
