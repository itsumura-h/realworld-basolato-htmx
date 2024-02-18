import ../../form_success_message/form_success_message_view_model

type FormMessageViewModel*  = object
  oobSwap*:bool
  formSuccessMessageViewModel*:FormSuccessMessageViewModel

proc init*(_:type FormMessageViewModel, oobSwap:bool, message:string): FormMessageViewModel =
  let formSuccessMessageViewModel = FormSuccessMessageViewModel.init(message)
  let viewModel = FormMessageViewModel(
    oobSwap: oobSwap,
    formSuccessMessageViewModel: formSuccessMessageViewModel
  )
  return viewModel
