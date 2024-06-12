type FormErrorMessageListViewModel* = object
  errors*:seq[string]


proc new*(_:type FormErrorMessageListViewModel, errors:seq[string]): FormErrorMessageListViewModel =
  return FormErrorMessageListViewModel(errors: errors)
