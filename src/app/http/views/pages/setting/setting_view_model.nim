import ../../../../usecases/get_login_user/get_login_user_dto
import ../../components/setting/form_message/form_message_view_model
import ../../components/setting/form/form_view_model


type SettingViewModel* = object
  fromMessageViewModel*:FormMessageViewModel
  formViewModel*:FormViewModel

proc init*(_:type SettingViewModel,
  getLoginUserDto:LoginUserDto,
):SettingViewModel =
  let fromMessageViewModel = FormMessageViewModel.init(
    false,
    "",
  )
  let formViewModel = FormViewModel.init(
    false,
    getLoginUserDto.name,
    getLoginUserDto.email,
    getLoginUserDto.bio,
    getLoginUserDto.image,
  )

  let viewModel = SettingViewModel(
    fromMessageViewModel: fromMessageViewModel,
    formViewModel: formViewModel,
  )
  return viewModel


proc init*(_:type SettingViewModel,
  name:string,
  email:string,
  bio:string,
  image:string,
  successMessage:string,
):SettingViewModel =
  let fromMessageViewModel = FormMessageViewModel.init(
    true,
    successMessage,
  )
  let formViewModel = FormViewModel.init(
    true,
    name,
    email,
    bio,
    image,
  )

  let viewModel = SettingViewModel(
    fromMessageViewModel: fromMessageViewModel,
    formViewModel: formViewModel,
  )
  return viewModel
