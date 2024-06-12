import basolato/view
import ./header_view_model

proc headerView*(viewModel:HeaderViewModel):Component =
  tmpl"""
    <nav class="navbar navbar-light">
      <div class="container">
        <a
          class="navbar-brand"
          href="/"
          hx-trigger="click"
          hx-get="/island/feed/global-feed"
          hx-target="#content"
          hx-push-url="/"
        >
          conduit
        </a>
        <ul class="nav navbar-nav pull-xs-right">
          $if viewModel.isLogin() {
            <li class="nav-item">
              <!-- Add active class when you are on that page -->
              <a
                class="nav-link active"
                href="/"
                hx-trigger="click"
                hx-get="/island/feed/global-feed"
                hx-target="#content"
                hx-push-url="/"
              >
                  Home
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="/editor">
                <i class="ion-compose"></i>New Article
              </a>
            </li>
            <li class="nav-item">
              <a
                class="nav-link"
                href="/settings"
                hx-trigger="click"
                hx-get="/island/settings"
                hx-target="#content"
                hx-push-url="/settings"
              >
                <i class="ion-gear-a"></i>Settings
              </a>
            </li>
            <li class="nav-item">
              <a
                class="nav-link"
                href="/profile/$(viewModel.user.id)"
                hx-trigger="click"
                hx-get="/island/profile/$(viewModel.user.id)"
                hx-target="#content"
                hx-push-url="/profile/$(viewModel.user.id)"
              >
                <img src="$(viewModel.user.imageUrl)" class="user-pic" />
                $(viewModel.user.name)
              </a>
            </li>
          }$else{
            <li class="nav-item">
              <!-- Add "active" class when you are on that page -->
              <a class="nav-link active" href="">Home</a>
            </li>
            <li class="nav-item">
              <a
                class="nav-link"
                href="/login"
                hx-trigger="click"
                hx-get="/island/login"
                hx-target="#content"
                hx-push-url="/login"
              >
                Sign in
              </a>
            </li>
            <li class="nav-item">
              <a
                class="nav-link"
                href="/register"
                hx-trigger="click"
                hx-get="/island/register"
                hx-target="#content"
                hx-push-url="/register"
              >Sign up</a>
            </li>
          }
        </ul>
      </div>
    </nav>
  """
