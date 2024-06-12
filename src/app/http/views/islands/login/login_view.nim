import basolato/view


proc islandLoginView*():Component =
  tmpl"""
    <div class="auth-page">
      <div class="container page">
        <div class="row">
          <div class="col-md-6 offset-md-3 col-xs-12">
            <h1 class="text-xs-center">Sign in</h1>
            <p class="text-xs-center">
              <a
                href="/register"
                hx-trigger="click"
                hx-get="/island/register"
                hx-target="#content"
                hx-push-url="/register"
              >Need an account?</a>
            </p>

            <div id="form-error-message-list"></div>

            <form
              method="POST"
              hx-post="/island/login"
              hx-target="#content"
            >
              $(csrfToken())
              <fieldset class="form-group">
                <input class="form-control form-control-lg" type="text" name="email" placeholder="Email" />
              </fieldset>
              <fieldset class="form-group">
                <input class="form-control form-control-lg" type="password" name="password" placeholder="Password" />
              </fieldset>
              <button class="btn btn-lg btn-primary pull-xs-right">Sign in</button>
            </form>
          </div>
        </div>
      </div>
    </div>
  """
