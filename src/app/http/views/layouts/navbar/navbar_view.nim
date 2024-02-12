import basolato/view
import ./navbar_view_model


proc navbarView*(viewModel:NavbarViewModel):Component =
  tmpli html"""
    <ul id="navbar" class="nav navbar-nav pull-xs-right" hx-swap-oob="true">
      <li class="nav-item">
        <a id="nav-link-home"
          href="/"
          hx-get="/htmx/home"
          hx-target="#app-body"
          hx-push-url="/"
          class="nav-link" 
        >
          Home
        </a>
      </li>

      $if not viewModel.isLogin{
        <li class="nav-item">
          <a id="nav-link-sign-in"
            href="/sign-in"
            hx-get="/htmx/sign-in"
            hx-target="#app-body"
            hx-push-url="/sign-in"
            class="nav-link" 
          >
            Sign in
          </a>
        </li>
        <li class="nav-item">
          <a id="nav-link-sign-up"
            href="/sign-up"
            hx-get="/htmx/sign-up"
            hx-target="#app-body"
            hx-push-url="/sign-up"
            class="nav-link"
          >
            Sign up
          </a>
        </li>
      }$else{
        <li class="nav-item">
          <a id="nav-link-editor"
            href="/editor"
            hx-get="/htmx/editor"
            hx-target="#app-body"
            hx-push-url="/editor"
            class="nav-link"
          >
            <i class="ion-compose"></i>
            New Article
          </a>
        </li>
        <li class="nav-item">
          <a id="nav-link-settings"
            href="/settings"
            hx-get="/htmx/settings"
            hx-target="#app-body"
            hx-push-url="/settings"
            class="nav-link"
          >
            Settings
          </a>
        </li>
        <li class="nav-item">
          <a id="nav-link-profile"
            href="/users/username"
            hx-get="/htmx/users/username"
            hx-target="#app-body"
            hx-push-url="/users/username"
            class="nav-link"
          >
            <img class="user-pic" src="$(viewModel.image)">
            $(viewModel.name)
          </a>
        </li>
      }
    </ul>
  """
