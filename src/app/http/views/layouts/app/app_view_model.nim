import ../header/header_view_model

type AppViewModel* = object
  title*:string
  headerViewModel*:HeaderViewModel


proc new*(_:type AppViewModel, title:string, headerViewModel:HeaderViewModel):AppViewModel =
  let viewModel = AppViewModel(
    title:title,
    headerViewModel:headerViewModel,
  )
  return viewModel
