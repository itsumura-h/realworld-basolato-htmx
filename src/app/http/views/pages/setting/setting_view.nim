import basolato/view
import ../../layouts/application/application_view_model
import ../../layouts/application/application_view
import ./setting_view_model
import ../../components/setting/form_message/form_message_view
import ../../components/setting/form/form_view


proc impl(viewModel:SettingViewModel):Component =
  tmpli html"""
    <div class="settings-page">
      <div class="container page">
        <div class="row">

          <div class="col-md-6 col-md-offset-3 col-xs-12">
            <h1 class="text-xs-center">Your Settings</h1>

            $(formMessageView(viewModel.fromMessageViewModel))

            $(formView(viewModel.formViewModel))
          </div>

          <div class="col-md-6 col-md-offset-3">
            <hr>
            <form hx-post="/htmx/logout" method="post">
              $(csrfToken())
              <button type="submit" class="btn btn-outline-danger">
                Or click here to logout.
              </button>
          </div>

        </div>
      </div>
    </div>
  """

proc settingView*(appViewModel:ApplicationViewModel, viewModel:SettingViewModel):string =
  return $applicationView(appViewModel, impl(viewModel)) 

proc htmxSettingView*(viewModel:SettingViewModel):string =
  return $impl(viewModel)
