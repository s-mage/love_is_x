defmodule LoveIsX.Reader do
  def read_file(tree, filename, ngram_size) do
    filename
    |> File.read!
    |> String.split("\n")
    |> Enum.map(&LoveIsX.Node.add_sentence(tree, &1, ngram_size))
    tree
  end
end
