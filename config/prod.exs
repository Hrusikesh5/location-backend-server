import Config

config :live_track, LiveTrack.RedisClient,
  host: System.get_env("REDIS_HOST"),
  port: String.to_integer(System.get_env("REDIS_PORT") || "6379")

config :live_track, LiveTrackWeb.Endpoint,
  url: [host: System.get_env("RENDER_EXTERNAL_HOSTNAME"), port: 443],
  check_origin: [
    "https://location-backend-server.onrender.com",
    "https://665b14fc979a3ea708b1f14d--tourmaline-moxie-e22666.netlify.app/",
    "//localhost",
    "//127.0.0.1"
  ],
  cache_static_manifest: "priv/static/cache_manifest.json",
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  http: [:inet6, port: String.to_integer(System.get_env("PORT") || "4000")]

config :logger, level: :info
