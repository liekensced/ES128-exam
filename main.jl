import REPL
using Random
using REPL.TerminalMenus

include("card_type.jl")
include("player_type.jl")

troef = 1
tableCards = []
players = []



for i in 1:4
  print("Enter name of player $i: ")
  name = "Name $i" #readline()
  push!(players, Player(name))
end

currentDeck = fullDeck()

function handOutCards()
  shuffle!(currentDeck.cards)
  for i in 1:4
    index = (i-1)*13
    players[i].deck.cards = currentDeck.cards[index + 1: index + 13]
  end
end
handOutCards()

for i in 1:2
  for i in 1:4
    player = players[i]
    println(player.name * " cards:")
    printCards(player)

    index = request("Select card: ", RadioMenu(map((card)-> rank_names[card.rank]*suit_names[card.suit] ,player.deck.cards),pagesize=7))
    
    #index = readInt("Select card: ", length(player.deck.cards))
    push!(tableCards, player.deck.cards[index])
    deleteat!(player.deck.cards, index)
    println(tableCards)
  
  end
end
println("done")
readline()

