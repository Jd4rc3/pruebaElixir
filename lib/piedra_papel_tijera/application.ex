defmodule PiedraPapelTijera.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: PiedraPapelTijera.Worker.start_link(arg)
      {Plug.Cowboy,
       scheme: :http,
       plug: PiedraPapelTijera.Router,
       options: [port: Application.get_env(:piedra_papel_tijera, :port)]},
      # {Mongo, [name: :mongo, database: Application.get_env(:piedra_papel_tijera, :database, pool_size: Application.get_env(:piedra_papel_tijera, :pool_size))]}
      {PiedraPapelTijera, [name: PiedraPapelTijera]}
      # {PiedraPapelTijera.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PiedraPapelTijera.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
