import basolato/controller
import ./libs/create_application_view_model
import ../views/pages/editor/editor_view_model
import ../views/pages/editor/editor_view


proc create*(context:Context, params:Params):Future[Response] {.async.} =
  let viewModel = EditorViewModel.new()
  let view = htmxEditorView(viewModel)
  return render(view)
