type SignInViewModel* = object
  oldEmail*:string

proc init*(_:type SignInViewModel, oldEmail:string): SignInViewModel =
  return SignInViewModel(oldEmail:oldEmail)
