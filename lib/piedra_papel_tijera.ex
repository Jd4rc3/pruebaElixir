defmodule PiedraPapelTijera do
  use GenServer

  def start_link(opts \\ [name: __MODULE__]) do
    GenServer.start_link(__MODULE__, nil, opts)
  end

  def init(nil) do
    {:ok, []}
  end

  def jugar({nombre, jugada}) do
    GenServer.call(__MODULE__, {nombre, jugada})
  end

  def comprobar() do
    GenServer.call(__MODULE__, :finished)
  end

  def handle_call({name, apuesta}, _from, state) do
    IO.inspect(state)

    if Enum.member?(state, {name, apuesta}) do
      {:reply, {:error, "Ya tiraste"}, state}
    else
      {:reply, {:ok, name}, [{name, apuesta} | state]}
    end
  end

  def handle_call(:reset, _from, _state) do
    {:reply, {:ok, "Reset"}, []}
  end

  def handle_call(:finished, _from, state) do
    IO.inspect(state)

    if length(state) == 2 do
      {:reply, {:ok, checkWinner(state)}, []}
    else
      {:reply, {:ok, "No hay ganador"}, state}
    end
  end

  def handle_info(any, state) do
    IO.puts(any)

    {:noreply, state}
  end

  def checkWinner(state) do
    [player1, player2] = state

    {nombre1, apuesta1} = player1
    {nombre2, apuesta2} = player2
    apuesta1 = String.to_atom(apuesta1)
    apuesta2 = String.to_atom(apuesta2)

    cond do
      apuesta1 == :tijera && apuesta2 == :piedra -> %{"ganador" => nombre2, "perdedor" => nombre1}
      apuesta1 == :piedra && apuesta2 == :tijera -> %{"ganador" => nombre1, "perdedor" => nombre2}
      apuesta1 == :tijera && apuesta2 == :papel -> %{"ganador" => nombre1, "perdedor" => nombre2}
      apuesta1 == :papel && apuesta2 == :tijera -> %{"ganador" => nombre2, "perdedor" => nombre1}
      apuesta1 == :piedra && apuesta2 == :papel -> %{"ganador" => nombre2, "perdedor" => nombre1}
      apuesta1 == :papel && apuesta2 == :piedra -> %{"ganador" => nombre1, "perdedor" => nombre2}
      apuesta1 == apuesta2 -> %{"ganador" => "Ninguno", "perdedor" => "Ninguno"}
    end
  end
end
