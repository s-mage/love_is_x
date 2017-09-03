defmodule LoveIsX.Generator do
  def generate_sentence(tree),            do: generate_sentence(tree, 3,  ["*"], 100)
  def generate_sentence(tree, ns),        do: generate_sentence(tree, ns, ["*"], 100)
  def generate_sentence(_, _, prev, 0),   do: prev

  def generate_sentence(tree, ns, start) when is_binary(start) do
    generate_sentence(tree, ns, Enum.reverse(["*" | String.split(start, ~r{\s})]), 100)
  end

  def generate_sentence(tree, ns, start) when is_list(start) do
    generate_sentence(tree, ns, ["*" | start], 100)
  end

  def generate_sentence(tree, ngram_size, prev, remaining_length) do
    node = LoveIsX.Node.child_in(tree, Enum.reverse(Enum.take(prev, ngram_size - 1)))
    case LoveIsX.Node.child(node, :rand.uniform()) do
      nil   -> Enum.join(Enum.drop(Enum.reverse(prev), 1), " ")
      child -> generate_sentence(
        tree, ngram_size,
        [LoveIsX.Node.val(child) | prev],
        remaining_length - 1)
    end
  end
end
