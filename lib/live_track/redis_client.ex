defmodule LiveTrack.RedisClient do
  use GenServer

  # Starts the GenServer
  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  # Initializes the Redis connection using the application configuration
  def init(:ok) do
    # Fetching configuration
    host = Application.get_env(:live_track, LiveTrack.RedisClient)[:host]
    port = Application.get_env(:live_track, LiveTrack.RedisClient)[:port]

    # Start a Redis connection with the specified host and port
    {:ok, conn} = Redix.start_link(host: host, port: port)
    {:ok, conn}
  end

  # Public API to set data in Redis
  def set(key, value) do
    GenServer.call(__MODULE__, {:set, key, value})
  end

  # Handle setting data in Redis
  def handle_call({:set, key, value}, _from, conn) do
    {:reply, Redix.command(conn, ["SET", key, value]), conn}
  end
end
