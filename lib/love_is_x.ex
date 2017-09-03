defmodule LoveIsX do
  @moduledoc """
  A Markov chains' generator.

  Usage
  -----

  ```elixir
    tree = LoveIsX.setup("data")

    LoveIsX.roll(tree)
    #= "woken with a kiss and a cup."

    LoveIsX.roll(tree, 2, "Love")
    #= "Love is that spark of his kiss to you."

    LoveIsX.teardown(tree)
    #= :ok
  ```
  """

  def setup(filename, ngram_size \\ 3) do
    LoveIsX.Node.init()
      |> LoveIsX.Reader.read_file(filename, ngram_size)
      |> LoveIsX.Node.setup_probabilities()
  end

  def roll(tree, ns \\ 3, start \\ []), do: LoveIsX.Generator.generate_sentence(tree, ns, start)

  def teardown(tree) do
    LoveIsX.Node.shutdown(tree)
  end
end
