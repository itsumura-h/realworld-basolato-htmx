import basolato/view
import ./head_view
import ./navbar_view


proc applicationView*(title:string, body:Component):Component =
  tmpli html"""
    <!DOCTYPE html>
    <html>
      $(headView(title))
    <body>
      $(navbarView())
      <div id="app-body">
        $(body)
      </div>
    </body>
    </html>
  """
