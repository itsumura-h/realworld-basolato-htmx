type FormFieldsViewModel* = object
  oldEmail*:string

proc init*(_:type FormFieldsViewModel, oldEmail=""):FormFieldsViewModel =
  return FormFieldsViewModel(
    oldEmail:oldEmail
  )
