defmodule LoveIsXTest.Node do
  use ExUnit.Case
  doctest LoveIsX.Node

  test "probabilities" do
    assert LoveIsX.Node.probabilities([3,2,3]) == [0.375, 0.625, 1.0]
  end

  test "add sentence" do
    tree = LoveIsX.Node.init()
    LoveIsX.Node.add_sentence(tree, "Love is sitting pretty")
    assert LoveIsX.Node.child(tree, "Love") != nil
  end
end
