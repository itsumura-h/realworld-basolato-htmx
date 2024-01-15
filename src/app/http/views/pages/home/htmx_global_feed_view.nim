# import std/json
import basolato/view
import ./htmx_global_feed_view_model


proc impl(viewModel:HtmxGlobalFeedViewModel):Component =
  tmpli html"""
    <div id="feed-post-preview" hx-swap-oob="true">
      $for article in viewModel.articles{
        <div class="post-preview">
          <div class="post-meta">
            <a href="/users/$(article.user.userName)"
              hx-push-url="/users/$(article.user.userName)"
              hx-get="/htmx/users/$(article.user.userName)"
              hx-target="#app-body"
            >
              <img src="$(article.user.image)" />
            </a>

            <div class="info">
              <a href="/users/$(article.user.userName)"
                hx-push-url="/users/$(article.user.userName)"
                hx-get="/htmx/users/$(article.user.userName)"
                hx-target="#app-body"
                class="author"
              >
                $(article.user.userName)
              </a>
              <span class="date">$(article.createdAt)</span>
            </div>

            <!-- if is_favorited, add class "active" -->
            <button class="btn btn-outline-primary btn-sm pull-xs-right"
              hx-post="/htmx/home/articles/$(article.id)/favorite"
              hx-swap="outerHTML"
            >
              <i class="ion-heart"></i> $(article.popularTagsCount)
            </button>

          </div>
          <a href="/articles/$(article.id)"
            hx-push-url="/articles/$(article.id)"
            hx-get="/htmx/articles/$(article.id)"
            hx-target="#app-body"
            class="preview-link"
          >
            <h1>$(article.title)</h1>
            <p>$(article.description)</p>

            <div class="m-t-1">
              <span>Read more...</span>

              <ul class="tag-list">
                $for tag in article.tags{
                  <li class="tag-default tag-pill tag-outline">$(tag.tagName)</li>
                }
              </ul>
            </div>
          </a>
        </div>
      }
        
      $if viewModel.articles.len() == 0{
        <div class="post-preview">
          <div class="alert alert-warning" role="alert">
            No articles are here... yet.
          </div>
        </div>
      }
    </div>

    $if viewModel.paginator.hasPages{
      <nav id="feed-pagination" hx-swap-oob="true">
        <ul class="pagination">
        $for i in 1..viewModel.paginator.lastPage{
          <li class="page-item $if viewModel.paginator.current == i { active }$else{}">
            <a class="page-link"
              href="/htmx/home/global-feed?page=$(i)"
              hx-push-url=""
              hx-get="/htmx/home/global-feed?page=$(i)"
            >$(i)</a>
          </li>
        }
        </ul>
      </nav>
    }$else{
      <nav id="feed-pagination" hx-swap-oob="true"></nav>
    }
  """

proc htmxGlobalFeedPageView*(viewModel:HtmxGlobalFeedViewModel):string =
  return $impl(viewModel)
