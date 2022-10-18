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
      case state do
        [{a, :tijera} | [{b, :piedra} | _tail]] ->
          {:reply, {:ok, %{"ganador" => a, "perdedor" => b}}, []}

        _ ->
          {:reply, {:ok, "No hay ganador"}, state}
      end
    else
      {:reply, {:ok, "No hay ganador"}, state}
    end
  end
end
