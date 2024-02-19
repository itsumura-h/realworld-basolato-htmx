import std/options
import std/sequtils
import ../../../../usecases/get_article_in_editor/get_article_in_editor_dto


type Tag* = object
  id*: string
  name*: string

proc new*(_:type Tag, id: string, name: string): Tag =
  return Tag(id:id, name:name)


type Article* = object
  id*:string
  title*: string
  description*: string
  body*: string
  tags*:string

proc new*(_:type Article, id: string, title: string, description: string, body: string, tags: seq[Tag]): Article =
  return Article(id:id, title:title, description:description, body:body, tags:tags)


type EditorViewModel* = object
  article*:Option[Article]

proc new*(_:type EditorViewModel): EditorViewModel =
  let article = none(Article)
  return EditorViewModel(article:article)


proc new*(_:type EditorViewModel, article: ArticleInEditorDto): EditorViewModel =
  let tags = article.tags.map(
    proc(tag:Tag):string =
      return tag.name
  )
  let tagStr = tags.join(" ")

  let article = Article.new(
    id: article.id,
    title: article.title,
    description: article.description,
    body: article.body,
    tags: tagStr
  )

  return EditorViewModel(article:article.some())
