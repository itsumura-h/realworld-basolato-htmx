import basolato/view
import ./user_feed_navigation_view_model


proc userFeedNavigationView*(viewModel:UserFeedNavigationViewModel):Component =
  tmpli html"""
    <ul id="user-feed-navigation" class="nav nav-pills outline-active" hx-swap-oob="true">
      $for item in viewModel.userFeedNavbarItems{
        <li class="nav-item">
          <a class="nav-link $if item.isActive{active}"
            href="$(item.url)"
            hx-push-url="$(item.url)"
            hx-get="$(item.hxGetUrl)"
            hx-trigger="click"
            hx-target="#user-post-preview"
          >
            $(item.title)
          </a>
        </li>
      }
    </ul>
  """
