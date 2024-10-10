import std/asyncdispatch
import basolato/view
import ../../../../presenters/user_article_list/user_article_list_presenter
import ../../components/feed_article/feed_article_component
import ../../components/paginator/paginator_component


proc userArticleListTemplate*():Future[Component] {.async.} =
  let presenter = UserArticleListPresenter.new()
  let model = presenter.invoke().await

  tmpl"""
    <div class="articles-toggle">
      <ul class="nav nav-pills outline-active">
        <li class="nav-item">
          <a class="nav-link active" href="">My Articles</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="">Favorited Articles</a>
        </li>
      </ul>
    </div>

    $for article in model.articleList{
      $(feedArticleComponent(article))
    }

    $(paginatorComponent(model.paginatorModel))
  """
