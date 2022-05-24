const DEBUG = false
const DEBUGBOT = false

import REPL
using Random
using REPL.TerminalMenus

include("card_type.jl")
include("player_type.jl")
include("ui.jl")
include("bot.jl")
include("games/points.jl")
include("games/round2.jl")
include("games/round3.jl")
include("games/round4.jl")
include("games/round5.jl")
#include("games/round7.jl")

global troef = 1
global tableCards = []
global players = []
global isWindows = Sys.iswindows()

# On a windows machine you can't run `clear` (the command does not exist)
## Repl.it runs in a linux environment so no probs there

function run(cmd)
  if(!isWindows)
    print("\n"^100)
    return
  end
  Base.run(cmd)
end

# Helper functions
function tweakedIndex(i, offset)
  return (i-offset+3)%4+1
end

#Start of code
for i in 1:4
  if(DEBUGBOT)
    name = "bot"
  elseif(DEBUG)
    name = "Player $i"
  else
    print("Enter name of player $i: ")
    name = readline()
    if (name == "bot" || contains(name, "bot "))
      #The \033[F \r will move the terminal cursor up and to the left, so it will rewrite the last line
      print("\033[F\rEnter name of player $i: ")
      printstyled("$name\n", color=:blue)
    end
  end
  push!(players, Player(name))
end

global currentDeck = fullDeck()

for game in 1:7
  handOutCards()
  for round in 1:13
    offset::Int64 = 0
    showTable(offset, game, round) #offset isn't correct but it doesn't matter
    for i in 1:4
      playerIndex::Int64 = (i + round + 2)%4 + 1
      
      offset = playerIndex - i
      player::Player = players[playerIndex]
      valids::Vector{Card} = validCards(player.deck.cards,tableCards)

      if (player.name == "bot" || contains(player.name, "bot "))
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
        showTable(offset, game, round)
        println("Hand over to next player")
        readline()
        run(`clear`)
      end
      
      showTable(offset, game, round)
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