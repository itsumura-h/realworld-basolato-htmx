import basolato/view
import ./delete_button_view_model

proc deleteButtonView*(viewModel:DeleteButtonViewModel):Component =
  tmpli html"""
    <button class="btn btn-outline-danger btn-sm delete-button"
      hx-delete="/htmx/articles/$(viewModel.articleId)"
      hx-target="#app-body"
      hx-confirm="Are you sure you wish to delete the article?"
    >
      <i class="ion-trash-a"></i>
      Delete Article
    </button>
  """
