import basolato/view
import ./feed_template_model
import ../../components/feed_article/feed_article_component


proc feedTemplate*():Future[Component] {.async.} =
  let model = FeedTemplateModel.new().await
  
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

      <ul class="pagination">
        <li class="page-item active">
          <a class="page-link" href="">1</a>
        </li>
        <li class="page-item">
          <a class="page-link" href="">2</a>
        </li>
      </ul>
    </div>
  """
