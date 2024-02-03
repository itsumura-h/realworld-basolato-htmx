import basolato/view
import ./favorite_button_view_model


proc favoriteButtonView*(viewModel:FavoriteButtonViewModel):Component =
  tmpli html"""
    <button class="btn btn-outline-primary btn-sm pull-xs-right $if viewModel.isFavorited{sctive}"
      hx-post="/htmx/users/articles/$(viewModel.articleId)/favorite"
      
      $if viewModel.isCurrentUser{
        hx-swap="delete"
        hx-target="closest .post-preview"
      }$else{
        hx-swap="outerHTML"
      }
    >
      <i class="ion-heart"></i> $(viewModel.favoriteCount)
    </button>
  """
