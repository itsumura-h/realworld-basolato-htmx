import basolato/view
import ./head_view
import ./navbar_view
import ./footer_view


proc applicationView*(title:string, body:Component):Component =
  tmpli html"""
    <!DOCTYPE html>
    <html>
      $(headView(title))
    <body hx-ext="head-support">
      <nav class="navbar navbar-light">
        <div class="container">
          <a class="navbar-brand" 
            href="/"
            hx-push-url="/"
            hx-get="/htmx/home" 
            hx-target="#app-body">conduit</a>
            
          $(navbarView())
        </div>
      </nav>

      <div id="app-body">
        $(body)
      </div>

      $(footerView())
    </body>
    </html>
  """
