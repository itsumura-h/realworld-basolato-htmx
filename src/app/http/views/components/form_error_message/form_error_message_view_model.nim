type FormErrorMessageViewModel*  = object
  errors*:seq[string]


proc init*(_:type FormErrorMessageViewModel, errors:seq[string]): FormErrorMessageViewModel =
  return FormErrorMessageViewModel(
    errors: errors
  )
