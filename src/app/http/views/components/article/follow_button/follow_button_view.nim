import basolato/view
import ./follow_button_view_model


proc followButtonView*(viewModel:FollowButtonViewModel):Component =
  tmpli html"""
    <form
      hx-post="/htmx/articles/follow-user/$(viewModel.userName)"

      $if viewModel.oobSwap{
        hx-swap-oob="outerHTML:.follow-button"
      }
    >
      <button class="btn btn-sm btn-outline-secondary follow-button">
        $if viewModel.isFollowed{
          <i class="ion-minus-round"></i>
          Unfollow
        }$else{
          <i class="ion-plus-round"></i>
          Follow
        }
        $(viewModel.userName) 
        <span class="counter">($(viewModel.followerCount))</span>
      </button>
    </form>
  """
