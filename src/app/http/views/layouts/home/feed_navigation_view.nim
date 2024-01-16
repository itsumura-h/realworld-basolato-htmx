import basolato/view
import ./feed_navigation_view_model


proc feedNavigationView*(feedNavbarItems:seq[FeedNavbar]):Component =
  tmpli html"""
    <ul id="feed-navigation" class="nav nav-pills outline-active" hx-swap-oob="true">
      $for item in feedNavbarItems{
        <li class="nav-item">
          <a class="nav-link $if item.isActive{active}"
            $if not item.isActive{
              href="$(item.hxPushUrl)"
              hx-get="$(item.hxGetUrl)"
              hx-trigger="click"
              hx-target="#feed-post-preview"
              hx-push-url="$(item.hxPushUrl)"
            }
          >
            $(item.title)
          </a>
        </li>
      }
    </ul>
  """
