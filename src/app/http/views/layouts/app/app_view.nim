import basolato/view
import ../head/head_view
import ../header/header_view
import ../footer/footer_view
import ./app_view_model


proc appView*(appViewModel:AppViewModel, content:Component):Component =
  tmpl"""
    <!DOCTYPE html>
    <html lang="en">
      $(headView(appViewModel.title))
    <body>
      $(headerView(appViewModel.headerViewModel))
      <div id="content">
        $(content)
      </div>
      $(footerView())
    </body>
    </html>
  """
