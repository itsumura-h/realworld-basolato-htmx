import basolato/view
import ../../islands/simple_favorite_button/simple_favorite_button_view
import ./article_preview_view_model


proc articlePreviewView*(viewModel:ArticlePreviewViewModel):Component =
  tmpl"""
    <div class="article-preview">
      <div class="article-meta">
        <a
          href="/profile/$(viewModel.author.id)"
          hx-get="/island/profile/$(viewModel.author.id)"
          hx-target="#content"
          hx-push-url="/profile/$(viewModel.author.id)"
        >
          <img src="$(viewModel.author.imageUrl)" />
        </a>
        <div class="info">
          <a
            class="author"
            href="/profile/$(viewModel.author.id)"
            hx-get="/island/profile/$(viewModel.author.id)"
            hx-target="#content"
            hx-push-url="/profile/$(viewModel.author.id)"
          >
            $(viewModel.author.name)
          </a>
          <span class="date">$(viewModel.createdAt)</span>
        </div>
        $(simpleFavoriteButtonView(viewModel.favoriteButtonViewModel))
      </div>
      <a
        class="preview-link"
        href="/article/$(viewModel.id)"
        hx-trigger="click"
        hx-get="/island/article/$(viewModel.id)"
        hx-target="#content"
        hx-push-url="/article/$(viewModel.id)"
      >
        <h1>$(viewModel.title)</h1>
        <p>$(viewModel.description)</p>
        <span>Read more...</span>
        <ul class="tag-list">
          $for tag in viewModel.tagList{
            <li class="tag-default tag-pill tag-outline">$(tag.name)</li>
          }
        </ul>
      </a>
    </div>
  """
