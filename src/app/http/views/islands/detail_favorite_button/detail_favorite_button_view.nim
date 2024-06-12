import basolato/view
import ./detail_favorite_button_view_model


proc detailFavoriteButtonView*(viewModel:DetailFavoriteButtonViewModel):Component =
  tmpl"""
    <form
      hx-trigger="submit"
      hx-post="/island/detail-favorite-button/$(viewModel.articleId)"
      hx-swap="outerHTML"
    >
      $(csrfToken())
      <button class="btn btn-sm btn-outline-primary $if viewModel.isFavorited{active}">
        <i class="ion-heart"></i>
        $if viewModel.isFavorited{
          Unfavorite Post
        }$else{
          Favorite Post
        }
        <span class="counter">($(viewModel.count))</span>
      </button>
    </form>
  """
