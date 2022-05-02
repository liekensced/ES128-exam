using Random

include("card_type.jl")
include("player_type.jl")

troef = 1

tableCards = []

players = []

for i in 1:4
  print("Enter name of player $i: ")
  name = readline()
  push!(players, Player(name))
end

currentDeck = fullDeck()
shuffle!(currentDeck.cards)

for i in 1:4
  index = (1-i)*14
  players[i].deck.cards = currentDeck.cards[i + 1: i + 14]
end

printCards(players[1])

println("done")
readline()