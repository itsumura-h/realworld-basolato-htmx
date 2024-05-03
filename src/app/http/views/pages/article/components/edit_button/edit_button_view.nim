import basolato/view
import ./edit_button_view_model


proc editButtonView*(viewModel:EditButtonViewModel):Component =
  tmpli html"""
    <button class="btn btn-outline-secondary btn-sm edit-button"
      hx-get="/htmx/editor/$(viewModel.articleId)"
      hx-target="#app-body"
      hx-push-url="/editor/$(viewModel.articleId)"
    >
      <i class="ion-edit"></i>
      Edit Article
    </button>
  """
