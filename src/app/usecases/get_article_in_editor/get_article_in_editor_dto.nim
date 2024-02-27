type TagDto* = object
  name*:string

proc new*(_:type TagDto, name:string): TagDto =
  return TagDto(name: name)


type ArticleInEditorDto* = object
  articleId*:string
  title*:string
  description*:string
  body*:string
  tags*:seq[TagDto]

proc new*(_:type ArticleInEditorDto,
  articleId:string,
  title:string,
  description:string,
  body:string,
  tags:seq[TagDto]
): ArticleInEditorDto =
  return ArticleInEditorDto(
    articleId: articleId,
    title: title,
    description: description,
    body: body,
    tags: tags
  )
