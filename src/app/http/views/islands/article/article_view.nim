import std/options
import basolato/view
import ../../components/edit_article_button/edit_article_button_view
import ../../components/delete_article_button/delete_article_button_view
import ../detail_follow_button/detail_follow_button_view
import ../detail_favorite_button/detail_favorite_button_view
import ../comment_list/comment_list_view
import ./article_view_model


proc islandArticleView*(viewModel:ArticleViewModel):Component =
  let style = styleTmpl(Css, """
    <style>
      .inline-block {
        display: inline-block;
      }
    </style>
  """)
  
  tmpl"""
    <div class="article-page">
      <div class="banner">
        <div class="container">
          <h1>$(viewModel.article.title)</h1>

          <div class="article-meta">
            <a href="/profile/$(viewModel.author.id)"><img src="$(viewModel.author.image)" /></a>
            <div class="info">
              <a href="/profile/$(viewModel.author.id)" class="author">$(viewModel.author.name)</a>
              <span class="date">$(viewModel.article.createdAt)</span>
            </div>
            $if viewModel.isAuthor{
              <div class="$(style.get("inline-block"))">
                $(editArticleButtonView(viewModel.editButtonViewModel.get))
              </div>
              <div class="$(style.get("inline-block"))">
                $(deleteArticleButtonView(viewModel.deleteButtonViewModel.get))
              </div>
            }$else{
              <div class="$(style.get("inline-block"))">
                $(detailFollowButtonView(viewModel.followButtonViewModel.get))
              </div>
              <div class="$(style.get("inline-block"))">
                $(detailFavoriteButtonView(viewModel.favoriteButtonViewModel.get))
              </div>
            }
          </div>
        </div>
      </div>

      <div class="container page">
        <div class="row article-content">
          <div class="col-md-12">
            <p>$(viewModel.article.body)</p>
            <ul class="tag-list">
              $for tag in viewModel.article.tagList{
                <li class="tag-default tag-pill tag-outline">$(tag.name)</li>
              }
            </ul>
          </div>
        </div>

        <hr />

        <div class="article-actions">
          <div class="article-meta">
            <a href="profile.html"><img src="$(viewModel.author.image)" /></a>
            <div class="info">
              <a href="" class="author">$(viewModel.author.name)</a>
              <span class="date">$(viewModel.article.createdAt)</span>
            </div>

            $if viewModel.isAuthor{
              <div class="$(style.get("inline-block"))">
                $(editArticleButtonView(viewModel.editButtonViewModel.get))
              </div>
              <div class="$(style.get("inline-block"))">
                $(deleteArticleButtonView(viewModel.deleteButtonViewModel.get))
              </div>
            }$else{
              <div class="$(style.get("inline-block"))">
                $(detailFollowButtonView(viewModel.followButtonViewModel.get))
              </div>
              <div class="$(style.get("inline-block"))">
                $(detailFavoriteButtonView(viewModel.favoriteButtonViewModel.get))
              </div>
            }
          </div>
        </div>

        <div class="row">
          $(commentListView(viewModel.commentListViewModel))
        </div>
      </div>
    </div>
    $(style)
  """
