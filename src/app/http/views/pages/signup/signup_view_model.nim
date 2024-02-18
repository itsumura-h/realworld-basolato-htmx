type SignUpViewModel*  = object
  oldName*:string
  oldEmail*:string

proc init*(_:type SignUpViewModel, oldName="", oldEmail=""):SignUpViewModel =
  return SignUpViewModel(
    oldName:oldName,
    oldEmail:oldEmail
  )
