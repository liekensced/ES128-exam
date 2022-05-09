
import REPL
using Random
using REPL.TerminalMenus

include("card_type.jl")
include("player_type.jl")
include("points.jl")


troef = 1
tableCards = []
players = []

function tableCardsStrings(i::Int64)
  if (length(tableCards) < i)
    return "*"
  end
  return card2str(tableCards[i])
end

function tweakedIndex(i, offset)
  return (i-offset+3)%4+1
end

for i in 1:4
  #print("Enter name of player $i: ")
  name = "Name $i" #readline()
  push!(players, Player(name))
end

currentDeck = fullDeck()
handOutCards()

# To test points.jl
#checkPoints([Card(1,2),Card(3,2),Card(1,5),Card(2,2)])
#print("end")
#readline()
#exit()
# ===


for round in 1:4
  for i in 1:4
    playerIndex = (i + round + 2)%4 + 1
    offset = playerIndex - i
    player = players[playerIndex]
    printstyled(player.name * " cards:\n", color=:cyan)
    printCards(player)
    valids = validCards(player.deck.cards,tableCards)
    index = request("Select card: ", RadioMenu(map((card)-> rank_names[card.rank]*suit_names[card.suit], valids),pagesize=7, charset=:unicode))
    run(`clear`)
    #index = readInt("Select card: ", length(player.deck.cards))
    choosen = valids[index]
    push!(tableCards, choosen)
    filter!(e::Card -> e.suit ≠ choosen.suit || e.rank ≠ choosen.rank, player.deck.cards)
    
    println(tableCards)
    println("\t\t"*tableCardsStrings(tweakedIndex(1,offset)))
    println("\t"*tableCardsStrings(tweakedIndex(2,offset))*"\t\t"*tableCardsStrings(tweakedIndex(4,offset)))
    println("\t\t"*tableCardsStrings(tweakedIndex(3,offset))) 
  end
  empty!(tableCards)
end



println("done")
readline()
