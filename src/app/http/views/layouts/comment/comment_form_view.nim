import basolato/view
import ../../pages/comment/comment_view_model


proc commentFormView*(article:Article, oobSwap:bool):Component =
  tmpli html"""
    <div id="form-message"></div>

    <form id="article-comment-form" class="card comment-form"
      hx-post="/htmx/articles/$(article.id)/comments" 
      hx-target="#article-comments-wrapper" hx-swap="afterbegin show:top"
      $if oobSwap{
        hx-swap-oob="true"
      }
    >
      <div class="card-block">
        <textarea class="form-control" placeholder="Write a comment..." rows="3" name="comment"></textarea>
      </div>
      <div class="card-footer">
        <img src="$(article.user.image)" class="comment-author-img" />
        <button class="btn btn-sm btn-primary">
          Post Comment
        </button>
      </div>
    </form>
  """
