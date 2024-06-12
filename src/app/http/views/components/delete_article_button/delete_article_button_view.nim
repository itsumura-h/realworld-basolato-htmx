import basolato/view
import ./delete_article_button_view_model


proc deleteArticleButtonView*(viewModel:DeleteArticleButtonViewModel):Component =
  tmpl"""
    <form
      method="post"
      action="/article/$(viewModel.articleId)/delete"
      hx-trigger="submit"
      hx-post="/island/article/$(viewModel.articleId)/delete"
    >
      $(csrfToken())
      <button class="btn btn-sm btn-outline-danger">
        <i class="ion-trash-a"></i> Delete Article
      </button>
    </form>
  """
