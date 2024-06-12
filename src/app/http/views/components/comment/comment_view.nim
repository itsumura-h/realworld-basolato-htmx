import basolato/view
import ./comment_view_model

proc commentView*(viewModel:CommentViewModel):Component =
  tmpl"""
    <div class="card">
      <div class="card-block">
        <p class="card-text">
          $(viewModel.body)
        </p>
      </div>
      <div class="card-footer">
        <a href="/profile/$(viewModel.authorId)" class="comment-author">
          <img src="$(viewModel.imageUrl)" class="comment-author-img" />
        </a>
        &nbsp;
        <a href="/profile/$(viewModel.authorId)" class="comment-author">$(viewModel.authorName)</a>
        <span class="date-posted">$(viewModel.createdAt)</span>
      </div>
    </div>
  """
