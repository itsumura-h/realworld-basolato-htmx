import basolato/view
import ../../pages/comment/comment_view_model


proc commentCardView*(comment:Comment):Component =
  tmpli html"""
    <div class="card">
      <div class="card-block">
        <p class="card-text">$(comment.body)</p>
      </div>
      <div class="card-footer">
        <a href="profile.html" class="comment-author">
          <img src="$(comment.user.image)" class="comment-author-img" />
        </a>
        &nbsp;
        <a href="/users/$(comment.user.username)"
          hx-push-url="/users/$(comment.user.username)"
          hx-get="/htmx/users/$(comment.user.username)"
          hx-target="#app-body"
          class="comment-author"
        >
          $(comment.user.name)
        </a>
        <span class="date-posted">$(comment.createdAt)</span>
      </div>
    </div>
  """
