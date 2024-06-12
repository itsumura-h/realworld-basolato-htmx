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
import ./app/http/controllers/feed_controller
import ./app/http/controllers/article_controller
# import ./app/http/controllers/user_controller
import ./app/http/controllers/authentication_controller
# import ./app/http/controllers/setting_controller
# # import ./app/http/controllers/editor_controller
# import ./app/http/controllers/island_sign_controller
# import ./app/http/controllers/island_home_controller
# import ./app/http/controllers/island_article_controller
# import ./app/http/controllers/island_user_controller
# import ./app/http/controllers/island_setting_controller
# # import ./app/http/controllers/htmx_editor_controller
import ./app/http/controllers/api_user_controller

import ./app/http/controllers/mock_controller


let routes = @[
  Route.group("", @[
    Route.group("", @[
      # ==================== mock start ====================
      # Route.get("/", mock_controller.globalFeed),
      # Route.get("/your-feed", mock_controller.yourFeed),
      # Route.get("/tag-feed", mock_controller.tagFeed),
      # Route.get("/register" , mock_controller.register),
      # Route.get("/login" , mock_controller.login),
      Route.get("/profile/{userId:str}" , mock_controller.profile),
      Route.get("/settings" , mock_controller.settings),
      # Route.get("/article/{articleId:str}" , mock_controller.article),

      Route.group("/island", @[
        # Route.get("/home/global-feed" , mock_controller.islandGlobalFeed),
        # Route.get("/home/your-feed" , mock_controller.islandYourFeed),
        # Route.get("/login" , mock_controller.islandLogin),
        # Route.get("/register" , mock_controller.islandRegister),
        Route.get("/profile/{userId:str}" , mock_controller.islandProfile),
        Route.get("/settings" , mock_controller.islandSetting),
        # Route.get("/article/{articleId:str}" , mock_controller.islandArticle),
      ]),
      # ==================== mock end ====================

      # ==================== implement start ====================
      Route.get("/", feed_controller.index),
      Route.get("/your-feed", feed_controller.yourFeed).middleware(should_login_middleware.shouldLogin),
      # Route.get("/tag-feed/{tag:str}", feed_controller.tagFeed),
      Route.get("/article/{articleId:str}", article_controller.show),

      Route.group("", @[
        Route.get("/register", authentication_controller.registerPage),
        Route.get("/login", authentication_controller.loginPage),
      ])
      .middleware(auth_middleware.loginSkip),

#       Route.get("/settings", setting_controller.index).middleware(should_login_middleware.shouldLogin),

#       Route.get("/articles/{articleId:str}", article_controller.show),

#       Route.get("/users/{userId:str}", user_controller.show),
#       # Route.get("/users/{userId:str}/favorites", user_controller.favorites),

#       # Route.get("/editor", editor_controller.create).middleware(should_login_middleware.shouldLogin),
#       # Route.get("/editor/{articleId:str}", editor_controller.update).middleware(should_login_middleware.shouldLogin),

      Route.group("/island", @[
        Route.get("/register", authentication_controller.islandRegisterPage),
        Route.post("/register", authentication_controller.register),
        Route.get("/login", authentication_controller.islandLoginPage),
        Route.post("/login", authentication_controller.login),
        Route.post("/logout", authentication_controller.logout),

#         Route.get("/settings", island_setting_controller.index).middleware(should_login_middleware.islandShouldLogin),
#         Route.post("/settings", island_setting_controller.update).middleware(should_login_middleware.islandShouldLogin),

        # Route.get("/home", island_home_controller.index),
        Route.get("/feed/global-feed", feed_controller.islandGlobalFeed),
        Route.get("/feed/your-feed", feed_controller.islandYourFeed).middleware(should_login_middleware.islandShouldLogin),
#         Route.get("/feed/tag-list", island_home_controller.tagList),
#         Route.get("/feed/tag-feed/{tagName:str}", island_home_controller.tagFeed),
#         Route.post("/feed/articles/{articleId:str}/favorite", island_home_controller.favorite).middleware(should_login_middleware.islandShouldLogin),

        Route.get("/article/{articleId:str}", article_controller.islandShow),
#         Route.get("/articles/{articleId:str}/comments", island_article_controller.comments),
#       #   Route.delete("/articles/{articleId:str}", island_article_controller.delete).middleware(should_login_middleware.islandShouldLogin),
#         Route.post("/articles/{articleId:str}/favorite", island_article_controller.favorite).middleware(should_login_middleware.islandShouldLogin),

#         Route.get("/users/{userId:str}", island_user_controller.show),
#         Route.get("/users/{userId:str}/articles", island_user_controller.articles),
#         # Route.get("/users/{userId:str}/favorites", island_user_controller.favoriteArticles),
#         Route.post("/users/{userId:str}/follow", island_user_controller.follow).middleware(should_login_middleware.islandShouldLogin),
#         Route.post("/users/articles/{articleId:str}/favorite", island_user_controller.favorite).middleware(should_login_middleware.islandShouldLogin),

#       #   Route.get("/editor", island_editor_controller.create).middleware(should_login_middleware.islandShouldLogin),
#       #   Route.post("/editor", island_editor_controller.store).middleware(should_login_middleware.islandShouldLogin),
#       #   Route.get("/editor/{articleId:str}", island_editor_controller.update).middleware(should_login_middleware.islandShouldLogin),
#       #   Route.post("/editor/{articleId:str}", island_editor_controller.edit).middleware(should_login_middleware.islandShouldLogin),
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

# let routes = @[
#   Route.group("", @[
#     Route.group("", @[
#       Route.get("/", mock_controller.globalFeed),
#       Route.get("/your-feed", mock_controller.yourFeed),
#       Route.get("/tag-feed", mock_controller.tagFeed),
#       Route.get("/register" , mock_controller.register),
#       Route.get("/login" , mock_controller.login),
#       Route.get("/profile/{userId:str}" , mock_controller.profile),
#       Route.get("/settings" , mock_controller.settings),

#       Route.group("/island", @[
#         Route.get("/home/global-feed" , mock_controller.islandGlobalFeed),
#         Route.get("/home/your-feed" , mock_controller.islandYourFeed),
#         Route.get("/login" , mock_controller.islandLogin),
#         Route.get("/register" , mock_controller.islandRegister),
#         Route.get("/profile/{userId:str}" , mock_controller.islandProfile),
#         Route.get("/settings" , mock_controller.islandSetting),
#       ])
#     ])
#     .middleware(checkCsrfToken)
#     .middleware(sessionFromCookie),
#   ])
#   .middleware(set_headers_middleware.setCorsHeaders)
# ]

serve(routes)
