type FormFieldsViewModel* = object
  oldEmail*:string

proc new*(_:type FormFieldsViewModel, oldEmail=""):FormFieldsViewModel =
  return FormFieldsViewModel(
    oldEmail:oldEmail
  )
