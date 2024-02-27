import std/options
import basolato/view
import ./article_show_view_model
import ../../layouts/application/application_view_model
import ../../layouts/application/application_view
import ../../components/article/follow_button/follow_button_view
import ../../components/article/favorite_button/favorite_button_view
import ../../components/article/edit_button/edit_button_view
import ../../components/article/delete_button/delete_button_view


proc impl(viewModel:ArticleShowViewModel):Component =
  tmpli html"""
    <div class="post-page">

      <div class="banner">
        <div class="container">

          <h1>$(viewModel.article.title)</h1>

          <div class="post-meta">
            <a href="profile.html"><img src="$(viewModel.user.image)" /></a>
            <div class="info">
              <a href="/users/$(viewModel.user.id)"
                hx-push-url="/users/$(viewModel.user.id)"
                hx-get="/htmx/users/$(viewModel.user.id)"
                hx-target="#app-body"
                class="author"
              >
                $(viewModel.user.name)
              </a>
              <span class="date">$(viewModel.article.createdAt)</span>
            </div>

            <!-- if author -->
            $if viewModel.isAuthor{
              <!-- edit-button -->
              $( editButtonView(viewModel.editButtonViewModel.get) )
              <!-- delete-button -->
              $( deleteButtonView(viewModel.deleteButtonViewModel.get) )
            }$else{
              <!-- follow button -->
              $( followButtonView(viewModel.followButtonViewModel.get) )
              <!-- favorite button -->
              $( favoriteButtonView(viewModel.favoriteButtonViewModel.get) )
            }
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
              <a href="/users/$(viewModel.user.id)"
                hx-push-url="/users/$(viewModel.user.id)"
                hx-get="/htmx/users/$(viewModel.user.id)"
                hx-target="#app-body"
                class="author"
              >
                $(viewModel.user.name)
              </a>
              <span class="date">$(viewModel.article.createdAt)</span>
            </div>

            <!-- if author -->
            $if viewModel.isAuthor{
              $( editButtonView(viewModel.editButtonViewModel.get) )
              <!-- delete-button -->
              $( deleteButtonView(viewModel.deleteButtonViewModel.get) )
            }$else{
              <!-- follow button -->
              $(followButtonView(viewModel.followButtonViewModel.get))
              <!-- favorite button -->
              $(favoriteButtonView(viewModel.favoriteButtonViewModel.get))
            }
          </div>
        </div>

        <div class="row">
          <div class="col-md-8 col-md-offset-2" hx-get="/htmx/articles/$(viewModel.article.id)/comments" hx-trigger="load"></div>
        </div>

      </div>

    </div>
  """

proc htmxArticleShowView*(viewModel:ArticleShowViewModel):string =
  return $impl(viewModel)

proc articleShowPageView*(appViewModel:ApplicationViewModel, viewModel:ArticleShowViewModel):string =
  return $applicationView(appViewModel, impl(viewModel))
