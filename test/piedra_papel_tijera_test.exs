defmodule PiedraPapelTijeraTest do
  # Bringing ExUnit's case module to scope and configure it to run
  # tests in this module concurrently with tests in other modules
  # https://hexdocs.pm/ex_unit/ExUnit.Case.html
  use ExUnit.Case, async: true

  # This makes the conn object avaiable in the scope of the tests,
  # which can be used to make the HTTP request
  # https://hexdocs.pm/plug/Plug.Test.html
  # use Plug.Test

  # We call the Plug init/1 function with the options then store
  # returned options in a Module attribute opts.
  # Note: @ is module attribute unary operator
  # https://hexdocs.pm/elixir/main/Kernel.html#@/1
  # https://hexdocs.pm/plug/Plug.html#c:init/1
  # @opts PiedraPapelTijera.Router.init([])

  test "piedra" do
    PiedraPapelTijera.jugar({"david", :piedra})
    PiedraPapelTijera.jugar({"jose", :tijera})
    assert PiedraPapelTijera.comprobar() == {:ok, %{"ganador" => "jose", "perdedor" => "david"}}
  end
end
