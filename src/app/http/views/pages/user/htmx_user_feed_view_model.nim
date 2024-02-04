import std/times
import std/sequtils
import std/strformat
import ../../../../usecases/get_articles_in_user/get_articles_in_user_dto
import ../../../../usecases/get_favorites_in_user/get_favorites_in_user_dto
import ../../layouts/favorite_button/favorite_button_view_model
import ../../layouts/user_feed_navigation/user_feed_navigation_view_model


type Author* = object
  id*:string
  name*:string
  image*:string

proc new*(_:type Author, id, name, image:string):Author =
  return Author(
    id:id,
    name:name,
    image:image,
  )


type Tag* = object
  name*:string

proc new*(_:type Tag, name:string):Tag =
  return Tag(
    name:name
  )


type FavoritedUser* = object
  id*:string

proc new*(_:type FavoritedUser, id:string):FavoritedUser =
  return FavoritedUser(
    id:id
  )


type Article* = object
  id*:string
  title*:string
  description*:string
  createdAt*:string
  author*:Author
  tags*:seq[Tag]
  favoritedUsers*:seq[FavoritedUser]
  favoriteButtonViewModel*:FavoriteButtonViewModel

proc new*(_:type Article,
  id:string,
  title:string,
  description:string,
  createdAt:DateTime,
  author:Author,
  tags:seq[Tag],
  favoritedUsers:seq[FavoritedUser],
  loginUserId:string
): Article =  
  var isFavorited = false
  for favoritedUser in favoritedUsers:
    if favoritedUser.id == loginUserId:
      isFavorited = true
      break
  
  let favoriteButtonViewModel = FavoriteButtonViewModel.new(
    isFavorited,
    id,
    loginUserId == author.id,
    favoritedUsers.len
  )

  let createdAt = createdAt.format("yyyy MMMM d")
  return Article(
    id:id,
    title:title,
    description:description,
    createdAt:createdAt,
    author:author,
    tags:tags,
    favoritedUsers:favoritedUsers,
    favoriteButtonViewModel:favoriteButtonViewModel
  )



type HtmxUserFeedViewModel* = object
  articles*:seq[Article]
  userFeedNavigationViewModel*:UserFeedNavigationViewModel

proc new*(_:type HtmxUserFeedViewModel, dto:GetArticlesInUserDto, loginUserId:string):HtmxUserFeedViewModel =
  let articles = dto.articles.map(
    proc(article:ArticleDto):Article =
      let author = Author.new(
        article.author.id,
        article.author.name,
        article.author.image,
      )

      let tags = article.tags.map(
        proc(tag:TagDto):Tag =
          return Tag.new(tag.name)
      )

      let favoritedUsers = article.favoritedUsers.map(
        proc(favoritedUser:FavoritedUserDto):FavoritedUser =
          FavoritedUser.new(favoritedUser.id)
      )

      let article = Article.new(
        article.id,
        article.title,
        article.description,
        article.createdAt,
        author,
        tags,
        favoritedUsers,
        loginUserId,
      )

      return article
  )

  let userFeedNavbarItems = @[
    UserFeedNavbar.new(
      "My Articles",
      true,
      "/users/" & dto.articles[0].author.id,
      &"/htmx/users/{dto.articles[0].author.id}/articles",
    ),
    UserFeedNavbar.new(
      "Favorited Articles",
      false,
      &"/users/{dto.articles[0].author.id}/favorites",
      &"/htmx/users/{dto.articles[0].author.id}/favorites",
    )
  ]

  let userFeedNavigationViewModel = UserFeedNavigationViewModel.new(userFeedNavbarItems)
  
  
  return HtmxUserFeedViewModel(
    articles:articles,
    userFeedNavigationViewModel:userFeedNavigationViewModel
  )



proc new*(_:type HtmxUserFeedViewModel, dto:GetFavoritesInUserDto, loginUserId:string):HtmxUserFeedViewModel =
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

      let favoritedUsers = article.favoritedUsers.map(
        proc(favoritedUser:get_favorites_in_user_dto.FavoritedUserDto):FavoritedUser =
          FavoritedUser.new(favoritedUser.id)
      )

      let article = Article.new(
        article.id,
        article.title,
        article.description,
        article.createdAt,
        author,
        tags,
        favoritedUsers,
        loginUserId,
      )

      return article
  )

  let userFeedNavbarItems = @[
    UserFeedNavbar.new(
      "My Articles",
      false,
      "/users/" & dto.user.id,
      &"/htmx/users/{dto.user.id}/articles",
    ),
    UserFeedNavbar.new(
      "Favorited Articles",
      true,
      &"/users/{dto.user.id}/favorites",
      &"/htmx/users/{dto.user.id}/favorites",
    )
  ]

  let userFeedNavigationViewModel = UserFeedNavigationViewModel.new(userFeedNavbarItems)
  
  
  return HtmxUserFeedViewModel(
    articles:articles,
    userFeedNavigationViewModel:userFeedNavigationViewModel
  )
