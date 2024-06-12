import basolato/view
import ./feed_navbar_view_model


proc feedNavbarView*(viewModel:FeedNavbarViewModel):Component =
  tmpl"""
    <div class="feed-toggle">
      <ul class="nav nav-pills outline-active">
        $if viewModel.isLogin(){
          <li class="nav-item">
            <a
              class="nav-link $if viewModel.feedType == YourFeed{active}"
              href="/your-feed"
              hx-trigger="click"
              hx-get="/island/feed/your-feed"
              hx-target="#content"
              hx-push-url="/your-feed"
            >
              Your Feed
            </a>
          </li>
        }
        <li class="nav-item">
          <a
            class="nav-link $if viewModel.feedType == GlobalFeed{active}"
            href="/"
            hx-trigger="click"
            hx-get="/island/feed/global-feed"
            hx-target="#content"
            hx-push-url="/"
          >
            Global Feed
          </a>
        </li>
        $if viewModel.feedType == TagFeed{
          <li class="nav-item active">
            <a
              class="nav-link active"
              href="/tag-feed/$(viewModel.tag.name)"
              hx-trigger="click"
              hx-get="/island/feed/tag-feed/$(viewModel.tag.name)"
              hx-target="#content"
              hx-push-url="/tag-feed/$(viewModel.tag.name)"
            >
              $(viewModel.tag.name)
            </a>
          </li>
        }
      </ul>
    </div>
  """
