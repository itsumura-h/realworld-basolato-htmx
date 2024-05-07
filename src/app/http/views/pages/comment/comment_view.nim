import basolato/view
import ./form/form_view
import ./card/card_view
import ./comment_view_model


proc impl(viewModel:CommentViewModel):Component =
  tmpli html"""
    $if not viewModel.isLogin{
      <div>
        <a href="/htmx/sign-in" hx-get="/htmx/sign-in" hx-target="#app-body"
          hx-push-url="/sign-in"
        >
          Sign in
        </a>
        or
        <a href="/htmx/sign-up" hx-get="/htmx/sign-up" hx-target="#app-body"
          hx-push-url="/sign-up"
        >
          sign up
        </a>
        to add comments on this article.
      </div>
    }$else{
      $(formView(viewModel.form, not viewModel.isLogin))
    }

    <div id="article-comments-wrapper">
      $for card in viewModel.cardList{
        $(cardView(card))
      }
    </div>
  """

proc commentView*(viewModel:CommentViewModel):Component =
  return impl(viewModel)
