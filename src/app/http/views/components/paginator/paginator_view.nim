import basolato/view
import ./paginator_view_model


proc paginatorView*(viewModel:PaginatorViewModel):Component =
  tmpl"""
    <ul class="pagination">
      $for i in 1..viewModel.lastPage{
        ${ let isActive = i == viewModel.current }
        <li class="page-item $if isActive{active}">
          <a
            class="page-link"
            $if not isActive{
              href="$(viewModel.hxPushUrl)?page=$(i)"
              hx-trigger="click"
              hx-get="$(viewModel.hxGetUrl)?page=$(i)"
              hx-target="#content",
              hx-push-url="$(viewModel.hxPushUrl)?page=$(i)"
              hx-swap="innerHTML show:window:top"
            }
          >
            $(i)
          </a>
        </li>
      }
    </ul>
  """
