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
import ./app/http/controllers/sign_controller
import ./app/http/controllers/htmx_sign_controller
import ./app/http/controllers/htmx_home_controller
import ./app/http/controllers/htmx_article_controller
import ./app/http/controllers/api_user_controller


let routes = @[
  Route.group("", @[
    Route.group("", @[
      Route.get("/", home_controller.index),
      
      Route.get("/sign-up", sign_controller.signUpPage),
      Route.get("/sign-in", sign_controller.signInPage),

      Route.get("/articles/{articleId:string}", article_controller.show),

      Route.group("/htmx", @[
        Route.post("/sign-up", htmx_sign_controller.signUp),
        Route.get("/home", htmx_home_controller.index),
        Route.get("/home/global-feed", htmx_home_controller.globalFeed),
        Route.get("/home/tag-list", htmx_home_controller.tagList),

        Route.get("/articles/{articleId:string}", htmx_article_controller.show),
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
