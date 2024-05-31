defmodule LiveTrackWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "tracking:lobby", LiveTrackWeb.TrackingChannel

  def connect(_params, socket, _connect_info) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
