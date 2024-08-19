import basolato/view
import ../../layouts/app/app_layout
import ../../templates/article/article_template


proc articlePage*():Future[Component] {.async.} =
  return appLayout("Article", articleTemplate().await).await
