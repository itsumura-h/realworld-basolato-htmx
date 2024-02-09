import basolato/view
import ../head_view
import ../navbar/navbar_view
import ../footer_view
import ./application_view_model


proc applicationView*(viewModel:ApplicationViewModel, body:Component):Component =
  tmpli html"""
    <!DOCTYPE html>
    <html>
      $(headView(viewModel.title))
    <body hx-ext="head-support">
      <nav class="navbar navbar-light">
        <div class="container">
          <a class="navbar-brand" 
            href="/"
            hx-push-url="/"
            hx-get="/htmx/home" 
            hx-target="#app-body">conduit</a>
            
          $(navbarView(viewModel.navbarViewModel))
        </div>
      </nav>

      <div id="app-body">
        $(body)
      </div>

      $(footerView())
    </body>
    </html>
  """
