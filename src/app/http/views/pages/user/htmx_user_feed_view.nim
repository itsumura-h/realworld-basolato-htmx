import basolato/view
import ./htmx_user_feed_view_model
import ../../components/user/favorite_button/favorite_button_view
import ../../components/user/feed_navigation/feed_navigation_view


proc impl(viewModel:HtmxUserFeedViewModel):Component =
  tmpli html"""
    $(feedNavigationView(viewModel.feedNavigationViewModel))

    <div id="user-post-preview" hx-swap-oob="true">
    $for article in viewModel.articles{
      <div class="post-preview">
        <div class="post-meta">
          <a href="/users/$(article.author.id)"
            hx-push-url="/users/$(article.author.id)"
            hx-get="/htmx/users/$(article.author.id)"
            hx-target="#app-body"
          >
            <img src="$(article.author.image)" />
          </a>
          <div class="info">
            <a href="/users/$(article.author.id)"
              hx-push-url="/users/$(article.author.id)"
              hx-get="/htmx/users/$(article.author.id)"
              hx-target="#app-body"
              class="author"
            >
              $(article.author.name)
            </a>
            <span class="date">$(article.createdAt)</span>
          </div>
      
          $(favoriteButtonView(article.favoriteButtonViewModel))

        </div>
        <a href="/articles/$(article.id)"
          hx-push-url="/articles/$(article.id)"
          hx-get="/htmx/articles/$(article.id)"
          hx-target="#app-body"
          class="preview-link"
        >
          <h1>$(article.title)</h1>
          <p>$(article.description)</p>

          <div>
            <span>Read more...</span>

            <ul class="tag-list">
              $for tag in article.tags{
                <li class="tag-default tag-pill tag-outline">$(tag.name)</li>
              }
            </ul>
          </div>
        </a>
      </div>
    }
    $if viewModel.articles.len == 0{
      <div class="post-preview">
        <div class="alert alert-warning" role="alert">
          No articles are here... yet.
        </div>
      </div>
    }
  </div>
  """

proc htmxUserFeedView*(viewModel:HtmxUserFeedViewModel):string =
  return $impl(viewModel)
