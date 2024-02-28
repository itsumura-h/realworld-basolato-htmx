# framework
import basolato
import basolato/middleware/session_from_cookie_middleware
import basolato/middleware/check_csrf_token_middleware
# middleware
# import ./app/http/middlewares/session_middleware
import ./app/http/middlewares/auth_middleware
import ./app/http/middlewares/set_headers_middleware
import ./app/http/middlewares/should_login_middleware
# controller
# import ./app/http/controllers/welcome_controller
import ./app/http/controllers/home_controller
import ./app/http/controllers/article_controller
import ./app/http/controllers/user_controller
import ./app/http/controllers/sign_controller
import ./app/http/controllers/setting_controller
import ./app/http/controllers/editor_controller
import ./app/http/controllers/htmx_sign_controller
import ./app/http/controllers/htmx_home_controller
import ./app/http/controllers/htmx_article_controller
import ./app/http/controllers/htmx_user_controller
import ./app/http/controllers/htmx_setting_controller
import ./app/http/controllers/htmx_editor_controller
import ./app/http/controllers/api_user_controller


let routes = @[
  Route.group("", @[
    Route.group("", @[
      Route.get("/", home_controller.index),
      Route.get("/global-feed", home_controller.index),
      Route.get("/tag-feed/{tag:str}", home_controller.tagFeed),

      Route.get("/sign-up", sign_controller.signUpPage).middleware(auth_middleware.loginSkip),
      Route.get("/sign-in", sign_controller.signInPage).middleware(auth_middleware.loginSkip),
      Route.get("/logout", sign_controller.logout).middleware(auth_middleware.loginSkip),

      Route.get("/settings", setting_controller.index).middleware(should_login_middleware.shouldLogin),

      Route.get("/articles/{articleId:str}", article_controller.show),

      Route.get("/users/{userId:str}", user_controller.show),
      Route.get("/users/{userId:str}/favorites", user_controller.favorites),

      Route.get("/editor", editor_controller.create).middleware(should_login_middleware.shouldLogin),
      Route.get("/editor/{articleId:str}", editor_controller.update).middleware(should_login_middleware.shouldLogin),

      Route.group("/htmx", @[
        Route.get("/sign-up", htmx_sign_controller.signUpPage),
        Route.post("/sign-up", htmx_sign_controller.signUp),
        Route.get("/sign-in", htmx_sign_controller.signInPage),
        Route.post("/sign-in", htmx_sign_controller.signIn),
        Route.post("/logout", htmx_sign_controller.logout),

        Route.get("/settings", htmx_setting_controller.index).middleware(should_login_middleware.htmxShouldLogin),
        Route.post("/settings", htmx_setting_controller.update).middleware(should_login_middleware.htmxShouldLogin),

        Route.get("/home", htmx_home_controller.index),
        Route.get("/home/global-feed", htmx_home_controller.globalFeed),
        Route.get("/home/tag-feed/{tagName:str}", htmx_home_controller.tagFeed),
        Route.get("/home/tag-list", htmx_home_controller.tagList),

        Route.get("/articles/{articleId:str}", htmx_article_controller.show),
        Route.get("/articles/{articleId:str}/comments", htmx_article_controller.comments),
        Route.delete("/articles/{articleId:str}", htmx_article_controller.delete).middleware(should_login_middleware.htmxShouldLogin),

        Route.get("/users/{userId:str}", htmx_user_controller.show),
        Route.get("/users/{userId:str}/articles", htmx_user_controller.articles),
        Route.get("/users/{userId:str}/favorites", htmx_user_controller.favorites),

        Route.get("/editor", htmx_editor_controller.create).middleware(should_login_middleware.htmxShouldLogin),
        Route.post("/editor", htmx_editor_controller.store).middleware(should_login_middleware.htmxShouldLogin),
        Route.get("/editor/{articleId:str}", htmx_editor_controller.update).middleware(should_login_middleware.htmxShouldLogin),
        Route.post("/editor/{articleId:str}", htmx_editor_controller.edit).middleware(should_login_middleware.htmxShouldLogin),
      ])
    ])
    .middleware(checkCsrfToken)
    .middleware(sessionFromCookie),

    Route.group("/api", @[
      # Route.get("/index", welcome_controller.indexApi),
      Route.post("/users", api_user_controller.create),
    ])
    .middleware(set_headers_middleware.setSecureHeaders)
  ])
  .middleware(set_headers_middleware.setCorsHeaders)
]

serve(routes)
