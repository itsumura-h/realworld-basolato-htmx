import basolato/view
import ./simple_favorite_button_view_model


proc simpleFavoriteButtonView*(viewModel: SimpleFavoriteButtonViewModel): Component =
  tmpl"""
    <form
      hx-post="/island/simple-favorite/$(viewModel.articleId)"

      $if viewModel.willDelete{
        hx-swap="delete"
        hx-target="closest .article-preview"
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
