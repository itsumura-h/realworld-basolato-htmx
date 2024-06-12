import basolato/view
import ./form_error_message_list_view_model


proc formErrorMessageListView*(viewModel:FormErrorMessageListViewModel):Component =
  tmpl"""
    <ul class="error-messages">
      $for error in viewModel.errors{
        <li>$(error)</li>
      }
    </ul>
  """
