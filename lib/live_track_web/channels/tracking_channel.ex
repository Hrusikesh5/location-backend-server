defmodule LiveTrackWeb.TrackingChannel do
  use LiveTrackWeb, :channel

  require Logger

  def join("tracking:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("new_location", %{"id" => id, "lat" => lat, "lon" => lon} = payload, socket) do
    Logger.info("Handling new location for #{id}")
    LiveTrack.RedisClient.set("driver:#{id}", "#{lat}:#{lon}")
    broadcast(socket, "location_update", payload)
    {:noreply, socket}
  end

  defp authorized?(_payload) do
    true  # Implement actual authorization logic
  end
end
