import basolato/view
import ../../../../presenters/feed/global_feed_presenter
import ./feed_template_model
import ../../components/feed_article/feed_article_component
import ../../components/paginator/paginator_component


proc feedTemplate*():Future[Component] {.async.} =
  let context = context()
  let feedType =
    if context.request.url.path == "/":
      global
    elif context.request.url.path == "/your-feed":
      yourFeed
    else:
      tag

  let model =
    case feedType
    of global:
      let presenter = GlobalFeedPresenter.new()
      presenter.invoke().await
    else:
      let presenter = GlobalFeedPresenter.new()
      presenter.invoke().await
    

  tmpl"""
    <div class="col-md-9">
      <div class="feed-toggle">
        <ul class="nav nav-pills outline-active">
          $if model.feedType == tag{
            <li class="nav-item">
              <a class="nav-link active" href="">$(model.tagName)</a>
            </li>
          }
          $if model.isLogin{
            <li class="nav-item">
              <a class="nav-link $if model.feedType == yourFeed{active}" href="/your-feed">Your Feed</a>
            </li>
          }
          <li class="nav-item">
            <a class="nav-link $if model.feedType == global{active}" href="/">Global Feed</a>
          </li>
        </ul>
      </div>

      $for article in model.articleList{
        $(feedArticleComponent(article))
      }

      $(paginatorComponent(model.paginatorModel))
    </div>
  """
