import basolato/view
import ./htmx_article_show_view_model
import ../../layouts/application_view


proc impl(viewModel:HtmxArticleShowViewModel):Component =
  tmpli html"""
    <div class="post-page">

      <div class="banner">
        <div class="container">

          <h1>$(viewModel.article.title)</h1>

          <div class="post-meta">
            <a href="profile.html"><img src="$(viewModel.user.image)" /></a>
            <div class="info">
              <a href="/users/$(viewModel.user.username)"
                hx-push-url="/users/$(viewModel.user.username)"
                hx-get="/htmx/users/$(viewModel.user.username)"
                hx-target="#app-body"
                class="author"
              >
                $(viewModel.user.name)
              </a>
              <span class="date">$(viewModel.article.createdAt)</span>
            </div>

            <!-- if author -->
              <!-- edit-button -->
              <!-- delete-button -->
            <!-- else -->
              <!-- follow button -->
              <!-- favorite button -->
          </div>

        </div>
      </div>

      <div class="container page">

        <div class="row post-content">
          <div class="col-md-12">
            $(viewModel.article.body)  
          </div>
          <div class="col-md-12 m-t-2">
            <ul class="tag-list">
              $for tag in viewModel.article.tags{
                <li class="tag-default tag-pill tag-outline">$(tag.tagName)</li>
              }
            </ul>
          </div>
        </div>

        <hr />

        <div class="post-actions">
          <div class="post-meta">
            <a href="profile.html"><img src="$(viewModel.user.image)" /></a>
            <div class="info">
              <a href="/users/$(viewModel.user.username)"
                hx-push-url="/users/$(viewModel.user.username)"
                hx-get="/htmx/users/$(viewModel.user.username)"
                hx-target="#app-body"
                class="author"
              >
                $(viewModel.user.name)
              </a>
              <span class="date">$(viewModel.article.createdAt)</span>
            </div>

            <!-- if author -->
              <!-- edit-button -->
              <!-- delete-button -->
            <!-- else -->
              <!-- follow button -->
              <!-- favorite button -->

          </div>
        </div>

        <div class="row">
          <div class="col-md-8 col-md-offset-2" hx-get="/htmx/articles/$(viewModel.article.id)/comments" hx-trigger="load"></div>
        </div>

      </div>

    </div>
  """

proc htmxArticleShowView*(viewModel:HtmxArticleShowViewModel):string =
  return $impl(viewModel)

proc articleShowPageView*(viewModel:HtmxArticleShowViewModel):string =
  let title = viewModel.article.title
  return $applicationView(title, impl(viewModel))
