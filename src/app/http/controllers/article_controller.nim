import std/asyncdispatch
import std/json
# framework
import basolato/controller
import basolato/request_validation
import basolato/view
import ../views/pages/article/htmx_article_show_view
import ../../data_stores/queries/get_article_query


proc show*(context:Context, params:Params):Future[Response] {.async.} =
  let articleId = params.getStr("articleId")
  let query = GetArticleQuery.new()
  let vieeModel = query.invoke(articleId).await
  let view = articleShowPageView(vieeModel)
  return render(view)
