type FormSuccessMessageViewModel* = object
  message*:string

proc init*(_:type FormSuccessMessageViewModel, message:string): FormSuccessMessageViewModel =
  return FormSuccessMessageViewModel(message: message)
