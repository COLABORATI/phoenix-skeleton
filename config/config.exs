# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the router
config :phoenix, Skeleton2.Router,
  url: [host: "localhost"],
  http: [port: System.get_env("PORT")],
  https: false,
  secret_key_base: "ykra3/SIekQYAeCjsyNIUDxuelKgo2C+Zdp75agH7+2Bj0ShOhxohpfV37QUioGd9CIPtx8p9HPOwW3w7Q9B6A==",
  catch_errors: true,
  debug_errors: false,
  error_controller: Skeleton2.PageController

# Session configuration
config :phoenix, Skeleton2.Router,
  session: [ store: :memcached, key: "skeletion2_key", table: :memcached_sessions ]

# mount static at /static
config :phoenix, Skeleton2.Router,
  static: [ at: "/static", from: Mix.Project.config[:app] ]

config :phoenix, :template_engines,
  dtl: PhoenixDtl.Engine
  
# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
