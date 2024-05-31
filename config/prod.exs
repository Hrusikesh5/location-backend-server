import Config

config :live_track, LiveTrack.RedisClient,
  host: System.get_env("REDIS_HOST"),
  port: String.to_integer(System.get_env("REDIS_PORT") || "6379")

config :live_track, LiveTrackWeb.Endpoint,
  url: [host: System.get_env("RENDER_EXTERNAL_HOSTNAME"), port: 443],
  cache_static_manifest: "priv/static/cache_manifest.json",
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  http: [:inet6, port: String.to_integer(System.get_env("PORT") || "4000")]

config :logger, level: :info

# If you have a database configuration, you can remove or comment it out if not used.
# config :live_track, LiveTrack.Repo,
#   username: System.get_env("DB_USERNAME"),
#   password: System.get_env("DB_PASSWORD"),
#   database: System.get_env("DB_NAME"),
#   hostname: System.get_env("DB_HOST"),
#   show_sensitive_data_on_connection_error: true,
#   pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")
