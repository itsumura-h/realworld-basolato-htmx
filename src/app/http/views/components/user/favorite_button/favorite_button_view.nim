import basolato/view
import ./favorite_button_view_model


proc favoriteButtonView*(viewModel: FavoriteButtonViewModel): Component =
  tmpli html"""
    <form
      hx-post="/htmx/users/articles/$(viewModel.articleId)/favorite"

      $if viewModel.isCurrentUser{
        hx-swap="delete"
        hx-target="closest .post-preview"
      }$else{
        hx-swap="outerHTML"
      }
    >
      $(csrfToken())
      <button class="btn btn-outline-primary btn-sm pull-xs-right $if viewModel.isFavorited{active}">
        <i class="ion-heart"></i>
        $(viewModel.count)
      </button>
    </form>
  """
