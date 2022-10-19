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

  post "/jugar" do
    case conn.body_params do
      %{"nombre" => jugador, "apuesta" => apuesta} ->
        case PiedraPapelTijera.jugar({jugador, apuesta}) do
          {:ok, resultado} ->
            response = Jason.encode!(resultado)

            conn
            |> put_resp_content_type("application/json")
            |> send_resp(200, response)

          {:error, _} ->
            send_resp(conn, 500, "Something went wrong")
        end

      _ ->
        send_resp(conn, 400, '')
    end
  end

  get "/comprobar" do
    {:ok, resultado} = PiedraPapelTijera.comprobar()

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(resultado))
  end
end
