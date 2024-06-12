import basolato/view
import ./edit_article_button_view_model


proc editArticleButtonView*(viewModel:EditArticleButtonViewModel):Component =
  tmpl"""
    <button
      class="btn btn-sm btn-outline-secondary"
      hx-trigger="click"
      hx-get="/island/editor/$(viewModel.articleId)"
      hx-target="#content"
      hx-push-url="/editor/$(viewModel.articleId)"
    >
      <i class="ion-edit"></i> Edit Article
    </button>
  """
