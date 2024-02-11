import basolato/view
import ../../form_success_message/form_success_message_view
import ./form_message_view_model


proc formMessageView*(viewModel:FormMessageViewModel):Component =
  tmpli html"""
    <div id="settings-form-message"
      $if viewModel.oobSwap{
        hx-swap-oob="true"
      }
    >
      $(formSuccessMessageView(viewModel.formSuccessMessageViewModel))
    </div>
  """
