import basolato/view
import ../../components/comment/comment_view
import ./comment_list_view_model


proc commentListView*(viewModel:CommentListViewModel):Component =
  tmpl"""
    <div class="col-xs-12 col-md-8 offset-md-2">
      $if viewModel.isLogin{
        <form class="card comment-form">
          <div class="card-block">
            <textarea class="form-control" placeholder="Write a comment..." rows="3"></textarea>
          </div>
          <div class="card-footer">
            <img src="http://i.imgur.com/Qr71crq.jpg" class="comment-author-img" />
            <button class="btn btn-sm btn-primary">Post Comment</button>
          </div>
        </form>
      }

      $for commentViewModel in viewModel.commentList{
        $(commentView(commentViewModel))
      }

    </div>
  """
