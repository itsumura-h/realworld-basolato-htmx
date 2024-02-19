type Tag* = object
  name*:string

proc new*(_:type Tag, name:string): Tag =
  return Tag(name: name)


type ArticleInEditorDto* = object
  articleId*:string
  title*:string
  description*:string
  body*:string
  tags*:seq[Tag]

proc new*(_:type ArticleInEditorDto,
  articleId:string,
  title:string,
  description:string,
  body:string,
  tags:seq[Tag]
): ArticleInEditorDto =
  return ArticleInEditorDto(articleId: articleId, title: title, description: description, body: body, tags: tags)
