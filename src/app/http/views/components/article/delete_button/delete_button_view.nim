import basolato/view
import ./delete_button_view_model

proc deleteButtonView*(viewModel:DeleteButtonViewModel):Component =
  let style = styleTmpl(Css, """
    <style>
      .form_inline {
        display: inline;
      }
    </style>
  """)

  tmpli html"""
  $(style)
    <form
      hx-delete="/htmx/articles/$(viewModel.articleId)"
      hx-target="#app-body"
      class="$(style.element("form_inline"))"
    >
      $(csrfToken())
      <button class="btn btn-outline-danger btn-sm delete-button"
        hx-confirm="Are you sure you wish to delete the article?"
      >
        <i class="ion-trash-a"></i>
        Delete Article
      </button>
    </form>
  """
