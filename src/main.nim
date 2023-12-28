# framework
import basolato
# middleware
import ./app/http/middlewares/session_middleware
import ./app/http/middlewares/auth_middleware
import ./app/http/middlewares/set_headers_middleware
# controller
import ./app/http/controllers/welcome_controller
import ./app/http/controllers/api_user_controller


let routes = @[
  Route.group("", @[
    Route.group("", @[
      Route.get("/", welcome_controller.index),
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
