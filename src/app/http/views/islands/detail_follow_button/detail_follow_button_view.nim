import basolato/view
import ./detail_follow_button_view_model


proc detailFollowButtonView*(viewModel:DetailFollowButtonViewModel):Component =
  tmpl"""
    <form
      hx-trigger="submit"
      hx-post="/island/detail-follow-button/$(viewModel.userId)"
      hx-swap="outerHTML"
    >
      $(csrfToken())
      <button class="btn btn-sm btn-outline-secondary">
        <i class="ion-plus-round"></i>
        $if viewModel.isFollowed{
          Unfollow
        }$else{
          Follow
        }
        $(" " & viewModel.userName)<span class="counter">($(viewModel.followerCount))</span>
      </button>
    </form>
  """
