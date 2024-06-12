import ../../http/views/islands/form_error_message_list/form_error_message_list_view_model


type FormErrorMessageListPresenter* = object

proc new*(_:type FormErrorMessageListPresenter):FormErrorMessageListPresenter =
  return FormErrorMessageListPresenter()


proc invoke*(self:FormErrorMessageListPresenter, errors:seq[string]):FormErrorMessageListViewModel =
  return FormErrorMessageListViewModel.new(errors)
