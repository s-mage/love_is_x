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

  def roll(tree),            do: LoveIsX.Generator.generate_sentence(tree)
  def roll(tree, ns),        do: LoveIsX.Generator.generate_sentence(tree, ns)
  def roll(tree, ns, start), do: LoveIsX.Generator.generate_sentence(tree, ns, start)

  def teardown(tree) do
    LoveIsX.Node.shutdown(tree)
  end
end
