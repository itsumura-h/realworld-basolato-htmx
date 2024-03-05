import std/times
import std/sequtils
import std/strformat
import ../../../../usecases/get_articles_in_user/get_articles_in_user_dto
import ../../../../usecases/get_favorites_in_user/get_favorites_in_user_dto
import ../../components/user/favorite_button/favorite_button_view_model
import ../../components/user/feed_navigation/feed_navigation_view_model


type Author*  = object
  id*:string
  name*:string
  image*:string

proc new*(_:type Author, id, name, image:string):Author =
  return Author(
    id:id,
    name:name,
    image:image,
  )


type Tag*  = object
  name*:string

proc new*(_:type Tag, name:string):Tag =
  return Tag(
    name:name
  )


type FavoritedUser*  = object
  id*:string

proc new*(_:type FavoritedUser, id:string):FavoritedUser =
  return FavoritedUser(
    id:id
  )


type Article*  = object
  id*:string
  title*:string
  description*:string
  createdAt*:string
  author*:Author
  tags*:seq[Tag]
  favoriteButtonViewModel*:FavoriteButtonViewModel

proc new*(_:type Article,
  id:string,
  title:string,
  description:string,
  createdAt:DateTime,
  author:Author,
  tags:seq[Tag],
  favoriteButtonViewModel:FavoriteButtonViewModel,
): Article =  
  let createdAt = createdAt.format("yyyy MMMM d")
  return Article(
    id:id,
    title:title,
    description:description,
    createdAt:createdAt,
    author:author,
    tags:tags,
    favoriteButtonViewModel:favoriteButtonViewModel
  )



type HtmxUserFeedViewModel*  = object
  articles*:seq[Article]
  feedNavigationViewModel*:FeedNavigationViewModel

proc new*(_:type HtmxUserFeedViewModel, dto:GetArticlesInUserDto):HtmxUserFeedViewModel =
  let author = Author.new(
    dto.author.id,
    dto.author.name,
    dto.author.image,
  )

  let articles = dto.articles.map(
    proc(article:ArticleDto):Article =
      let tags = article.tags.map(
        proc(tag:TagDto):Tag =
          return Tag.new(tag.name)
      )

      let favoriteButtonViewModel = FavoriteButtonViewModel.new(article.favoriteButtonDto)

      let article = Article.new(
        article.id,
        article.title,
        article.description,
        article.createdAt,
        author,
        tags,
        favoriteButtonViewModel,
      )

      return article
  )

  let feedNavbarItems = @[
    UserFeedNavbar.new(
      "My Articles",
      true,
      "/users/" & dto.author.id,
      &"/htmx/users/{dto.author.id}/articles",
    ),
    UserFeedNavbar.new(
      "Favorited Articles",
      false,
      &"/users/{dto.author.id}/favorites",
      &"/htmx/users/{dto.author.id}/favorites",
    )
  ]

  let feedNavigationViewModel = FeedNavigationViewModel.new(feedNavbarItems)
  
  
  return HtmxUserFeedViewModel(
    articles:articles,
    feedNavigationViewModel:feedNavigationViewModel
  )



proc new*(_:type HtmxUserFeedViewModel, dto:GetFavoritesInUserDto):HtmxUserFeedViewModel =
  let articles = dto.articles.map(
    proc(article:get_favorites_in_user_dto.ArticleDto):Article =
      let author = Author.new(
        article.author.id,
        article.author.name,
        article.author.image,
      )

      let tags = article.tags.map(
        proc(tag:get_favorites_in_user_dto.TagDto):Tag =
          return Tag.new(tag.name)
      )

      let favoriteButtonViewModel = FavoriteButtonViewModel.new(article.favoriteButtonDto)

      let article = Article.new(
        article.id,
        article.title,
        article.description,
        article.createdAt,
        author,
        tags,
        favoriteButtonViewModel,
      )

      return article
  )

  let feedNavbarItems = @[
    UserFeedNavbar.new(
      "My Articles",
      false,
      &"/users/{dto.user.id}",
      &"/htmx/users/{dto.user.id}/articles",
    ),
    UserFeedNavbar.new(
      "Favorited Articles",
      true,
      &"/users/{dto.user.id}/favorites",
      &"/htmx/users/{dto.user.id}/favorites",
    )
  ]

  let feedNavigationViewModel = FeedNavigationViewModel.new(feedNavbarItems)
  
  
  return HtmxUserFeedViewModel(
    articles:articles,
    feedNavigationViewModel:feedNavigationViewModel
  )
