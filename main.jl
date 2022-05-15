DEBUG = false 
DEBUGBOT = true
import REPL
using Random
using REPL.TerminalMenus

include("card_type.jl")
include("player_type.jl")
include("points.jl")
include("ui.jl")
include("bot.jl")


global troef = 1
global tableCards = []
global players = []


function tweakedIndex(i, offset)
  return (i-offset+3)%4+1
end

for i in 1:4
  if(DEBUG)
    name = "Name $i"
  elseif(DEBUGBOT)
    name = "bot"
  else
    print("Enter name of player $i: ")
    name = readline()
  end
  push!(players, Player(name))
end

currentDeck = fullDeck()
handOutCards()

for game in 1:7
  for round in 1:4
    offset = 0
    for i in 1:4
      playerIndex = (i + round + 2)%4 + 1
      
      offset = playerIndex - i
      player = players[playerIndex]
      valids = validCards(player.deck.cards,tableCards)

      if (player.name == "bot")
        index = botPlay(player.deck.cards, tableCards)
      else
        printstyled(player.name * " cards:\n", color=:cyan)
        printCards(player)
        
        
        index = request("Select card: ", RadioMenu(map((card)-> rank_names[card.rank]*suit_names[card.suit], valids),pagesize=7, charset=:unicode))
        
      end
      run(`clear`)
      choosen = valids[index]
      
      push!(tableCards, choosen)
      filter!(e::Card -> e.suit ≠ choosen.suit || e.rank ≠ choosen.rank, player.deck.cards)
  
      if(!DEBUG && i != 4)
        showTable(offset)
        println("Hand over to next player")
        readline()
        run(`clear`)
      end
      
      showTable(offset)
    end
    checkPoints(tableCards, offset, round, game)
  
    for player in players
      println(player.name*" points:"*string(player.points))
    end
    readline()
    run(`clear`)
    
    empty!(tableCards)
  end
end


println("done")
readline()
