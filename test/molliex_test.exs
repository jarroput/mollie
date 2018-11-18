defmodule MollieTest do
  use ExUnit.Case
  doctest Mollie

  test "greets the world" do
    assert Mollie.hello() == :world
  end
end
