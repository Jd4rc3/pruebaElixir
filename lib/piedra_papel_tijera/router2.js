defmodule PiedraPapelTijera.Router do
  use Plug.Router

  plug(Plug.Logger)

  plug(:match)

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  )

  plug(:dispatch)

  # post "/jugar" do
  # case conn.body_params do
  # %{"jugador1" => jugador1, "jugador2" => jugador2} ->
  # case PiedraPapelTijera.jugar(jugador1, jugador2) do
  # {:ok, resultado} ->
  # resultado
  # |> Jason.encode!()
  # |> send_resp(200, resultado)

  # {:error, _} ->
  # send_resp(conn, 500, "Something went wrong")
  # end

  # _ ->
  # send_resp(conn, 400, '')
  # end
  # end
end
