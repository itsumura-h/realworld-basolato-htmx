# framework
import basolato
# middleware
import ./app/http/middlewares/session_middleware
import ./app/http/middlewares/auth_middleware
import ./app/http/middlewares/set_headers_middleware
# controller
# import ./app/http/controllers/welcome_controller
import ./app/http/controllers/home_controller
import ./app/http/controllers/article_controller
import ./app/http/controllers/user_controller
import ./app/http/controllers/sign_controller
import ./app/http/controllers/htmx_sign_controller
import ./app/http/controllers/htmx_home_controller
import ./app/http/controllers/htmx_article_controller
import ./app/http/controllers/htmx_user_controller
import ./app/http/controllers/api_user_controller


let routes = @[
  Route.group("", @[
    Route.group("", @[
      Route.get("/", home_controller.index),
      
      Route.get("/sign-up", sign_controller.signUpPage),
      Route.get("/sign-in", sign_controller.signInPage),

      Route.get("/articles/{articleId:str}", article_controller.show),

      Route.get("/users/{userId:str}", user_controller.show),
      Route.get("/users/{userId:str}/favorites", user_controller.favorites),

      Route.group("/htmx", @[
        Route.post("/sign-up", htmx_sign_controller.signUp),
        Route.get("/home", htmx_home_controller.index),
        Route.get("/home/global-feed", htmx_home_controller.globalFeed),
        Route.get("/home/tag-feed/{tagName:str}", htmx_home_controller.tagFeed),
        Route.get("/home/tag-list", htmx_home_controller.tagList),

        Route.get("/articles/{articleId:str}", htmx_article_controller.show),
        Route.get("/articles/{articleId:str}/comments", htmx_article_controller.comments),

        Route.get("/users/{userId:str}", htmx_user_controller.show),
        Route.get("/users/{userId:str}/articles", htmx_user_controller.articles),
        Route.get("/users/{userId:str}/favorites", htmx_user_controller.favorites),

      ])
    ])
    .middleware(session_middleware.sessionFromCookie)
    .middleware(auth_middleware.checkCsrfToken),

    Route.group("/api", @[
      # Route.get("/index", welcome_controller.indexApi),
      Route.post("/users", api_user_controller.create),
    ])
    .middleware(set_headers_middleware.setSecureHeaders)
  ])
  .middleware(set_headers_middleware.setCorsHeaders)
]

serve(routes)
