use Mix.Config

config :phoenix, Hello2.Router,
  port: System.get_env("PORT") || 4000,
  ssl: false,
  host: "localhost",
  cookies: true,
  session_key: "_hello2_key",
  session_secret: "BDG8GOGD6ET_BE_#PQ!HD1DC*!JI^)F1LX^1%L#G3FQ#0!PU(&FJZP3F_FD1*O148V5337X3XVB0EB2",
  debug_errors: true

config :phoenix, :code_reloader,
  enabled: true

config :logger, :console,
  level: :debug


