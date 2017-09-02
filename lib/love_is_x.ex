defmodule LoveIsX do
  @moduledoc """
  Documentation for LoveIsX.
  """

  def setup(filename), do: setup(filename, 3)
  def setup(filename, ngram_size) do
    tree = LoveIsX.Node.init()
    tree
      |> LoveIsX.Reader.read_file(filename, ngram_size)
      |> LoveIsX.Node.setup_probabilities()
    tree
  end
end
