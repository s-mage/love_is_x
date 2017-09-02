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

LoveIsX.Generator.generate_sentence(tree)
#= ""is a lazy morning sleep-in."

LoveIsX.Generator.generate_sentence(tree, 3, "Love is")
#= "Love is just what you need to start off the new year."
```
