# realworld-basolato-htmx

- DTO
  - クエリサービスで作られる
  - Presenterで呼ばれる
  - ViewModelに対応する

## 参照系
### Presenter
- DBから値を取り出し、Viewを構築し返す
- コントローラーの中で呼ばれる
- 文脈を作る

### ViewModel
- 表示に関するロジックを持つ
- 

### View
- ViewModelに依存する

Controller
↓
Presenter
↓
Query Service
↓
DTO

---


### プレゼンテーション層
- View(ViewModel):string
- ViewModel(DTO)
  - → DTO
 
- 記事一覧
  - ArticlePreviewView
  - ArticlePreviewViewModel
- いいねボタン
  - FavoriteButtonView
  - FavoriteButtonViewModel
- ヘッダーのログイン状態
  - AppView
  - AppViewModel

### アプリケーション層
- Presenter():DTO
  - ※必ずしもQueryServiceを呼ぶわけではない
  - → Query Interface
  - → DTO

- article_preview/
  - 最新の記事一覧                GlobalFeedPresenter
  - フォローしている人の記事一覧  YourFeedPresenter
  - いいねした記事一覧            FavoritesInUserPresenter
  - タグ付けされた記事一覧        TagFeedPresenter
- app/
  - ヘッダーのログイン状態  AppPresenter

### ドメイン層
- /article_preview  記事一覧
  - DTO               ArticlePreviewDto
  - Query Interface   IArticlePreviewQuery
- /favorite_button  いいねボタン
  - DTO               FavoriteButtonDto
  - Query Interface   IFavoriteButtonQuery
- /user ログインIDからユーザー情報取得
  - DTO               UserDto
  - Query Interface   IUserQuery


### インフラ層
- Query():DTO
  - → Query Service Interface
  - → DTO

- 最新の記事一覧取得                GlobalFeedQuery
- フォローしている人の記事一覧取得  YourFeedQuery
- いいねした記事一覧取得            FavoritesInUserQuery
- いいねボタン取得                  TagFeedQuery
- ログインIDからユーザー情報取得    UserQuery
