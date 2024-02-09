import basolato/view
import ./favorite_button_view_model


proc favoriteButtonView*(viewModel:FavoriteButtonViewModel):Component =
  tmpli html"""
    <button class="btn btn-outline-primary btn-sm $(viewModel.isFavorited){active} favorite-button"
      hx-post="/htmx/articles/$(viewModel.articleId)/favorite"

      $if viewModel.oobSwap{
        hx-swap-oob="outerHTML:.favorite-button"
      }
    >
      <i class="ion-heart"></i>
      $if viewModel.isFavorited{
        Unfavorite Post
      }$else{
        Favorite Post
      }
      ($viewModel.favoriteCount)
    </button>
  """
