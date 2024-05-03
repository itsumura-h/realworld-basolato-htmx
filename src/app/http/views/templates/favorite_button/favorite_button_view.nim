import basolato/view
import ./favorite_button_view_model


proc favoriteButtonView*(viewModel: FavoriteButtonViewModel): Component =
  tmpli html"""
    <form
      hx-post="/htmx/articles/$(viewModel.articleId)/favorite"
      hx-swap="outerHTML"
    >
      $(csrfToken())
      <button class="btn btn-outline-primary btn-sm pull-xs-right $if viewModel.isFavorited{active}">
        <i class="ion-heart"></i>
        $if viewModel.isFavorited{
          Unfavorite Post
        }$else{
          Favorite Post
        }
        $(viewModel.count)
      </button>
    </form>
  """
