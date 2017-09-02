defmodule LoveIsXTest do
  use ExUnit.Case
  doctest LoveIsX

  test "greets the world" do
    assert LoveIsX.hello() == :world
  end
end
