# realworld-basolato-htmx
Simplicity is the ultimate sophistication.


### プレゼンテーション層
- View(ViewModel):string
- ViewModel(DTO)
  - → DTO

  ---

- 記事一覧
  - ArticlePreviewView
  - ArticlePreviewViewModel
- いいねボタン
  - FavoriteButtonView
  - FavoriteButtonViewModel
- ヘッダーのログイン状態
  - AppView
  - AppViewModel
  
  ---

- ComponentのViewModelとDtoは単数形の単位で紐づける
- 複数形のViewModelはPresenterの中でループして作る
- 複数形のViewはIslandの中でループして作る

### アプリケーション層
Presenterの返り値のViewModelの単位でまとめる
返り値のViewModelはIslandかPagesのもの
Presenterで文脈固有の操作をするので、ドメイン層には「どう呼ばれるか」から関数名の命名はしない

- Presenter():ViewModel
  - ※必ずしもQueryServiceを呼ぶわけではない
  - → Query Interface
  - → ViewModel

  ---

- feed/
  - 最新の記事一覧                GlobalFeedPresenter
  - フォローしている人の記事一覧  YourFeedPresenter
  - いいねした記事一覧            FavoritesInUserPresenter
  - タグ付けされた記事一覧        TagFeedPresenter
- app/
  - ヘッダーのログイン状態  AppPresenter

### ドメイン層
DTOの単位でまとめる

- /article_with_author  記事一覧
  - DTO               ArticleWithAuthorDto
  - Query Interface   IGlobalFeedArticleListQuery
  - Query Interface   IYourFeedArticleListQuery
  - Query Interface   IFavoriteArticleListInUserQuery
  - Query Interface   ITagFeedArticleListQuery
- /favorite_button  いいねボタン
  - DTO               FavoriteButtonDto
  - Query Interface   IFavoriteButtonQuery
- /user ログインIDからユーザー情報取得
  - DTO               UserDto
  - Query Interface   IUserQuery


### インフラ層
クエリの返り値のDTOの単位でまとめる

- Query():DTO
  - → Query Service Interface
  - → DTO

  ---

- article_with_author/
  - 最新の記事一覧取得                GlobalFeedArticleListQuery
  - フォローしている人の記事一覧取得  YourFeedArticleListQuery
  - いいねした記事一覧取得            FavoriteArticleListInUserQuery
  - タグに紐づく記事一覧取得          TagFeedArticleListQuery
- favoriteButton/
  - いいねボタン取得                  favoriteButtonQuery
- user/
  - ログインIDからユーザー情報取得    UserQuery

---

Atomicデザインは以下のようにモジュールを分割する

- Atoms:
  - 汎用的な機能を提供する。
  - ドメインが入ってはいけない。
  - Contextへのアクセスはしない。
  - 自分自身で状態はなるべく持たない。
  - 他のコンポーネントに依存していなければAtoms。
- Molecules:
  - 汎用的な機能を提供する。
  - ドメインが入ってはいけない。
  - Contextへのアクセスはしない。
  - 自分自身で状態はなるべく持たない。
  - 他のAtomsやMoleculesのコンポーネントに依存している。
- Organisms:
  - ドメインが入ったらOrganisms。
  - 他に依存するコンポーネントがなかったとしても、ドメインが入った時点でOrganismsにする。
  - useContextによるContext接続可。
  - その機能のためのAPIを叩くのはここ。
- Templates:
  - 部分導入した範囲内のレイアウトを決める。
  - ロジックは持たない。
- Pages:
  - 現在はただのラッパーに近い。

---

https://note.com/tabelog_frontend/n/n07b4077f5cf3

- Components
  - 文脈を持たないもの
  - 純関数
  - AtomsとMolecules
- Templates
  - 文脈を持つもの、DTOに依存する
  - Contextからデータを取得する
  - 副作用がある
  - ViewModelがある
  - Organismsを各ページ配下に
- Pages
  - コントローラーから呼ばれるもの
  - 副作用がある
  - ViewModelがある
  - TemplatesとPagesをまとめて

---

AstroJSの場合

https://docs.astro.build/ja/basics/project-structure/

- layouts
  - 複数のページで共有されるUI構造
- components
  - 再利用可能なコードの単位
- pages
  - プレゼン層から呼ばれるもの

---
