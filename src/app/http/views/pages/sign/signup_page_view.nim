import basolato/view
import ../../layouts/application_view


proc impl():Component =
  tmpli html"""
    <div class="auth-page">
      <div class="container page">
        <div class="row">

          <div class="col-md-6 col-md-offset-3 col-xs-12">
            <h1 class="text-xs-center">Sign up</h1>
            <p class="text-xs-center">
              <a 
                href="/sign-in"
                hx-push-url="/sign-in"
                hx-get="/htmx/sign-in" 
                hx-target="#app-body"
              >
                Have an account?
              </a>
            </p>

            <div id="sign-up-form-messages"></div>

            <form method="POST" hx-post="/htmx/sign-up" hx-target="#app-body">
              <fieldset class="form-group">
                <input id="sign-up-username" class="form-control form-control-lg" type="text" name="username" placeholder="Username" value="">
              </fieldset>
              <fieldset class="form-group">
                <input id="sign-up-email" class="form-control form-control-lg" type="text" name="email" placeholder="Email" value="">
              </fieldset>
              <fieldset class="form-group">
                <input id="sign-up-password" class="form-control form-control-lg" type="password" name="password" placeholder="Password">
              </fieldset>
              <button class="btn btn-lg btn-primary pull-xs-right">
                Sign up
              </button>
            </form>
          </div>

        </div>
      </div>
    </div>
  """


proc signUpPageView*():string =
  let title = "sign up"
  return $applicationView(title, impl())
