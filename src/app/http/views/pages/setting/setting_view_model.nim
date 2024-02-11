import ../../../../usecases/get_setting/get_setting_dto
import ../../components/setting/form_message/form_message_view_model
import ../../components/setting/form/form_view_model


type SettingViewModel* = object
  fromMessageViewModel*:FormMessageViewModel
  formViewModel*:FormViewModel

proc new*(_:type SettingViewModel,
  getSettingDto:GetSettingDto,
  successMessage="",
):SettingViewModel =
  let fromMessageViewModel = FormMessageViewModel.new(
    false,
    successMessage,
  )
  let formViewModel = FormViewModel.new(
    false,
    getSettingDto.name,
    getSettingDto.email,
    getSettingDto.bio,
    getSettingDto.image,
  )

  let viewModel = SettingViewModel(
    fromMessageViewModel: fromMessageViewModel,
    formViewModel: formViewModel,
  )
  return viewModel
