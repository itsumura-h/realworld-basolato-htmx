import basolato/view
import ../../layouts/application_view


proc impl():Component =
  tmpli html"""
    <div class="home-page">
      <div class="banner">
        <div class="container">
          <h1 class="logo-font">conduit</h1>
          <p>A place to share your knowledge.</p>
        </div>
      </div>

      <div class="container page">
        <div class="row">

          <div class="col-md-9">
            <div class="feed-toggle">
              <ul id="feed-navigation" class="nav nav-pills outline-active"></ul>
            </div>

            <div id="feed-post-preview"
              hx-trigger="load"
              hx-get="/htmx/home/global-feed"
            ></div>

            <nav id="feed-pagination"></nav>
          </div>

          <div class="col-md-3">
            <div class="sidebar">
              <p>Popular Tags</p>

              <div id="popular-tag-list" class="tag-list"
                hx-trigger="load"
                hx-get="/htmx/home/tag-list"
              ></div>
            </div>
          </div>

        </div>
      </div>
    </div>
  """


proc homePageView*():string =
  let title = "conduit"
  return $applicationView(title, impl())
