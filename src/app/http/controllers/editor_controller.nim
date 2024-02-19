import basolato/controller
import ./libs/create_application_view_model
import ../views/pages/editor/editor_view_model
import ../views/pages/editor/editor_view


proc index*(context:Context, params:Params):Future[Response] {.async.} =
  let appViewModel = createApplicationViewModel(context, "Editor ―Conduit").await
  let viewModel = EditorViewModel.new()
  let view = editorView(appViewModel, viewModel)
  return render(view)
