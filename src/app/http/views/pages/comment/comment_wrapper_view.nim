import basolato/view
import ../../components/comment/card_view
import ../../components/comment/form_view
import ./comment_view_model


proc impl(viewModel:CommentViewModel):Component =
  tmpli html"""
    <div id="article-comments-wrapper">
      $for comment in viewModel.comments{
        $(cardView(comment))
      }
    </div>

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
      $(formView(viewModel.article, not viewModel.isLogin))
    }
  """

proc commentWrapperView*(viewModel:CommentViewModel):string =
  $impl(viewModel)
