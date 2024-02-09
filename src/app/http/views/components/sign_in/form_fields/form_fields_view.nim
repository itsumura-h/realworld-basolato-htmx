import basolato/view
import ./form_fields_view_model


proc formFieldsView*(viewModel:FormFieldsViewModel):Component =
  tmpli html"""
    $(csrfToken())
    <fieldset class="form-group">
      <input type="text" id="sign-in-email" class="form-control form-control-lg" name="email" placeholder="Email" value="$(viewModel.oldEmail)">
    </fieldset>
    <fieldset class="form-group">
      <input type="password" id="sign-in-password" class="form-control form-control-lg" name="password" placeholder="Password">
    </fieldset>
    <button class="btn btn-lg btn-primary pull-xs-right">
      Sign in
    </button>
  """
