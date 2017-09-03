defmodule LoveIsX.Node do
  use Agent

  @sentence_begin "*"
  @enforce_keys [:value, :weight, :children]

  defstruct [:value, :weight, :probability, :children, :ngram_size]
  @type t :: %LoveIsX.Node{
    :value => String.t,
    :weight => pos_integer(), # how many times word occured
    :probability => Float.t,  # see probabilities function
    :ngram_size => pos_integer(),
    :children => [pid()] }

  def init() do
    start_link(%LoveIsX.Node{
      value: @sentence_begin,
      weight: 1,
      probability: 1,
      children: []})
  end

  def start_link(node) do
    {:ok, agent} = Agent.start_link(fn -> node end)
    agent
  end

  def shutdown(node) do
    Enum.map(children(node), &Agent.stop(&1))
    Agent.stop(node)
  end

  def add_sentence(tree_agent, sentence), do: add_sentence(tree_agent, sentence, 3)
  def add_sentence(tree_agent, sentence, ngram_size) do
    [@sentence_begin | String.split(sentence, ~r{\s})]
      |> cons(ngram_size)
      |> Enum.map(&add_ngram(&1, tree_agent))
  end

  def add_ngram(ngram, tree_agent) do
    Enum.reduce ngram, tree_agent, fn(word, agent) ->
       add_or_inc_child(agent, word)
       child(agent, word)
    end
  end

  def inc(agent) do
    Agent.update(agent, &Map.put(&1, :weight, &1.weight + 1))
  end

  def add_child(agent, value) do
    Agent.update(agent, &Map.put(&1,
      :children,
      [start_link(%LoveIsX.Node{value: value, weight: 1, children: []}) | &1.children]
    ))
  end

  def child(nil, _), do: nil
  def child(agent, value) do
    Agent.get agent, &(el(&1, value))
  end

  def child_in(node, []), do: node
  def child_in(node, values) do
    Enum.reduce values, node, fn(x, r) -> r && child(r, x) end
  end

  def el(node, value) when is_binary(value) do
    Enum.find(node.children, &(val(&1) == value))
  end

  def el(node, prob) when is_float(prob) do
    Enum.find(node.children, &(probability(&1) > prob))
  end

  def children(agent) do
    Agent.get(agent, &(&1.children))
  end

  def val(agent) do
    Agent.get(agent, &(&1.value))
  end

  def weight(agent) do
    Agent.get(agent, &(&1.weight))
  end

  def probability(agent) do
    Agent.get(agent, &(&1.probability))
  end

  def add_or_inc_child(agent, value) do
    case child(agent, value) do
      nil   -> add_child(agent, value)
      child -> inc(child)
    end
  end

  def setup_probabilities(agent) do
    Agent.get(agent, &(&1.children))
      |> Enum.map(&setup_probabilities(&1))
      |> children_probabilities
      |> Enum.map(fn({prob, node}) -> Agent.update(node, &Map.put(&1, :probability, prob)) end)
      |> Enum.all?(&(&1 == :ok))
    agent
  end

  @doc """
    When you pick next child you select it by
      :rand.uniform() - x.probability < 0
    where x.probability is probability of a node
  """
  def probabilities(weights) do
    weights
      |> Enum.map(&(&1 / Enum.sum(weights)))
      |> Enum.reduce({0, []}, fn(x, {acc, res}) -> {acc + x, [acc + x | res]} end)
      |> elem(1)
      |> Enum.reverse()
  end

  def children_probabilities(children) do
    children
      |> Enum.map(&weight(&1))
      |> probabilities()
      |> Enum.zip(children)
  end

  def cons([], _), do: []
  def cons([_ | tail] = list, count), do: [Enum.take(list, count) | cons(tail, count)]
end
