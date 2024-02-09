import basolato/view
import ../../layouts/application/application_view_model
import ../../layouts/application/application_view
import ./signin_view_model


proc impl(viewModel:SignInViewModel):Component =
  tmpli html"""
    <div class="auth-page">
      <div class="container page">
        <div class="row">

          <div class="col-md-6 col-md-offset-3 col-xs-12">
            <h1 class="text-xs-center">Sign in</h1>
            <p class="text-xs-center">
              <a
                href="/sign-up"
                hx-push-url="/sign-up"
                hx-get="/htmx/sign-up"
                hx-target="#app-body"
              >
                Need an account?
              </a>
            </p>

            <div id="sign-in-form-messages"></div>

            <form method="POST" hx-post="/htmx/sign-in" hx-target="#app-body">
              $(csrfToken())
              <fieldset class="form-group">
                <input type="text" id="sign-in-email" class="form-control form-control-lg" name="email" placeholder="Email" value="$(viewModel.oldEmail)">
              </fieldset>
              <fieldset class="form-group">
                <input type="password" id="sign-in-password" class="form-control form-control-lg" name="password" placeholder="Password">
              </fieldset>
              <button class="btn btn-lg btn-primary pull-xs-right">
                Sign in
              </button>
            </form>
          </div>

        </div>
      </div>
    </div>
  """


proc signInView*(appViewModel:ApplicationViewModel, viewModle:SignInViewModel):string =
  return $applicationView(appViewModel, impl(viewModle))

proc htmxSignInView*(viewModl:SignInViewModel):string =
  return $impl(viewModl)
