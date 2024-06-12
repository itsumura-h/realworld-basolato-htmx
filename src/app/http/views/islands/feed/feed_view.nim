import basolato/view
import ../../components/feed_navbar/feed_navbar_view
import ../../components/article_preview/article_preview_view
import ../../components/paginator/paginator_view
import ./feed_view_model


proc islandFeedView*(viewModel:FeedViewModel):Component =
  tmpl"""
    <div class="home-page">
      <div class="banner">
        <div class="container">
          <h1 class="logo-font">conduit</h1>
          <p>A place to share your knowledge.</p>
        </div>
      </div>

      <div class="container page">
        <div class="row">
          <div class="col-md-9" id="article-list">
            $(feedNavbarView(viewModel.feedNavbarViewModel))
    
            $if viewModel.articlePreviewViewModelList.len == 0{
              <div class="article-preview">
                <p>No articles are here... yet.</p>
              </div>
            }$else{
              $for articlePreviewViewModel in viewModel.articlePreviewViewModelList{
                $(articlePreviewView(articlePreviewViewModel))
              }
              $(paginatorView(viewModel.paginatorViewModel))
            }

          </div>
    
          <div class="col-md-3">
            <div class="sidebar">
              <p>Popular Tags</p>
    
              <div class="tag-list">
                <a href="/tag-feed" class="tag-pill tag-default">programming</a>
                <a href="/tag-feed" class="tag-pill tag-default">javascript</a>
                <a href="/tag-feed" class="tag-pill tag-default">emberjs</a>
                <a href="/tag-feed" class="tag-pill tag-default">angularjs</a>
                <a href="/tag-feed" class="tag-pill tag-default">react</a>
                <a href="/tag-feed" class="tag-pill tag-default">mean</a>
                <a href="/tag-feed" class="tag-pill tag-default">node</a>
                <a href="/tag-feed" class="tag-pill tag-default">rails</a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  """
