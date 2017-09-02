defmodule LoveIsX.Reader do
  def read_file(filename, tree) do
    filename
     |> File.read!
     |> String.split("\n")
     |> Enum.map(&LoveIsX.Node.add_sentence(tree, &1))
  end
end
