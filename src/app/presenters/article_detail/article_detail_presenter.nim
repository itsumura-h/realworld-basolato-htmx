import std/asyncdispatch
import ../../models/dto/article_detail/article_detail_query_interface
import ../../http/views/templates/article/article_template_model
import ../../di_container


type ArticleDetailPresenter* = object
  articleDetailQuery*: IArticleDetailQuery

proc new*(_:type ArticleDetailPresenter): ArticleDetailPresenter =
  return ArticleDetailPresenter(
    articleDetailQuery: di.articleDetailQuery
  )


proc invole*(self:ArticleDetailPresenter, articleId:string): Future[ArticleTemplateModel] {.async.} =
  let articleDto = self.articleDetailQuery.getArticleById(articleId).await
  
  let author = articleDto
