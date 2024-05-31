defmodule LiveTrackWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :live_track

  @session_options [
    store: :cookie,
    key: "_live_track_key",
    signing_salt: "pEHi9VUT",
    same_site: "Lax"
  ]

  socket "/socket", LiveTrackWeb.UserSocket, websocket: true, longpoll: false

  socket "/live", Phoenix.LiveView.Socket,
    websocket: [connect_info: [session: @session_options]],
    longpoll: [connect_info: [session: @session_options]]

  plug Plug.Static,
    at: "/",
    from: :live_track,
    gzip: false,
    only: LiveTrackWeb.static_paths()

  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options

  # Add the CORSPlug here
  plug CORSPlug, origin: "*"

  plug LiveTrackWeb.Router
end
