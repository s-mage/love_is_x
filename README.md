Love is...
=======

... a Markov chains generator. Now you can define what is love.


A Markov chain?
-----------

A Markov chain (discrete-time Markov chain or DTMC) named after Andrey Markov, is a mathematical system that undergoes transitions from one state to another, among a finite or countable number of possible states. (c) [Wikipedia](http://en.wikipedia.org/wiki/Markov_chain)


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
