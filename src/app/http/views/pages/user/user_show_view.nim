import basolato/view
import ../../layouts/application_view
import ../../layouts/users/follow_button_view
import ./user_show_view_model


proc impl(viewModel:UserShowViewModel):Component =
  tmpli html"""
    <div class="profile-page">
      <div class="user-info">
        <div class="container">
          <div class="row">

            <div class="col-md-10 col-md-offset-1">
              <img src="$(viewModel.user.image)" class="user-img" />
              <h4>$(viewModel.user.name)</h4>
              <p>$(viewModel.user.bio)</p>

              $if viewModel.user.isSelf{
                <a class="btn btn-sm btn-outline-secondary action-btn"
                  href="/settings"
                  hx-push-url="/settings"
                  hx-get="/htmx/settings"
                  hx-target="#app-body"
                >
                  <i class="ion-ios-gear"></i>
                  &nbsp;
                  Edit Profile Settings</span>
                </a>
              }$else{
                $(followButtonView(viewModel.followButtonViewModel))
              }
            </div>

          </div>
        </div>
      </div>

      <div class="container">
        <div class="row">
          <div class="col-md-10 col-md-offset-1">
            <div class="posts-toggle">
              <ul id="user-feed-navigation" class="nav nav-pills outline-active"></ul>
            </div>
            
            <div id="user-post-preview"
              $if viewModel.loadFavorites{
                hx-get="/htmx/users/$(viewModel.user.id)/favorites"
              }$else{
                hx-get="/htmx/users/$(viewModel.user.id)/articles"
              }
              hx-trigger="load"
            ></div>
          </div>
        </div>
      </div>
    </div>
  """

proc userShowView*(viewModel:UserShowViewModel):string =
  $application_view("users", impl(viewModel))


proc htmxUserShowView*(viewModel:UserShowViewModel):string =
  $impl(viewModel)
