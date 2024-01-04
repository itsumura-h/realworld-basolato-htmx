import basolato/view
import ./head_view


proc applicationView*(title:string, body:Component):Component =
  tmpli html"""
    <!DOCTYPE html>
    <html>
      $(headView(title))
    <body>
      $(body)
    </body>
    </html>
  """
