import basolato/view
import ../../di_container
import ../../models/dto/user/user_query_interface
import ../../models/vo/user_id
import ../../http/views/templates/setting/setting_template_model


type SettingPresenter* = object
  userQuery:IUserQuery

proc new*(_:type SettingPresenter):SettingPresenter =
  return SettingPresenter(
    userQuery: di.userQuery
  )


proc invoke*(self:SettingPresenter):Future[SettingTemplateModel] {.async.} =
  let context = context()
  let (params, errors) = context.getParamsWithErrorsList().await

  if errors.len > 0:
    let model = SettingTemplateModel.new(
      errors,
      params.old("image"),
      params.old("name"),
      params.old("bio"),
      params.old("email")
    )
    return model
  else:
    let strUserId = context.get("user_id").await
    let userId = UserId.new(strUserId)

    let dto = self.userQuery.getUserById(userId).await
    let model = SettingTemplateModel.new(
      dto.image,
      dto.name,
      dto.bio,
      dto.email,
    )
    return model
