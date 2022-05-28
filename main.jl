try
  using Firebase
catch
  import Pkg
  println("Need to install dependencies, this might takes some minutes")
  Pkg.add("Firebase")

  using Firebase
end

const PATH = "/king_game/v1/game2"

const PLAYERINDEX = isempty(ARGS) ? 1 : parse(Int64, ARGS[1])

redirect_stdout(devnull) do
  Firebase.realdb_init("https://julia-firebase-default-rtdb.europe-west1.firebasedatabase.app/")
end

const ONLINE = true
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
include("helper.jl")


global troef = 1
global isWindows = Sys.iswindows()
# On a windows machine you can't run `clear` (the command does not exist)
## Repl.it runs in a linux environment so no probs there


# Helper functions
function run(cmd)
  if (isWindows)
    print("\n"^100)
    return
  end
  Base.run(cmd)
end

global currentDeck = fullDeck()

function tweakedIndex(i, offset)
  return (i - offset + 3) % 4 + 1
end

function init()
  tableCards = []
  players = []
  game, round = (1, 1)

  if (Firebase.realdb_get(PATH) === nothing)
    for i in 1:4
      if (DEBUGBOT)
        name = "bot"
      elseif (DEBUG)
        name = "Name $i"
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

    handOutCards(players)
    pushData(tableCards, players, 1, 1)
  else
    tableCards, players, game, round = syncData()
  end
  gameCycle(tableCards, players, game, round)
  showTable(players, tableCards, 0, 1, 1)
end

global currentDeck = fullDeck()


function gameCycle(tableCards::Array, players::Array, game::Int64, round::Int64)
  i = length(tableCards) + 1

  playerIndex::Int64 = (i + round + 2) % 4 + 1

  offset = playerIndex - i

  if (i <= 4)
    player::Player = players[playerIndex]
    valids::Vector{Card} = validCards(player.deck.cards, tableCards)

    isBot::Bool = player.name == "bot" || contains(player.name, "bot ")
    if (isBot && PLAYERINDEX == 1)
      index = botPlay(player.deck.cards, tableCards)
    elseif (ONLINE && PLAYERINDEX != playerIndex && player.name != "$PLAYERINDEX")
      sleep(1)
      tableCards, players, game, round = syncData()
      run(`clear`)
      showTable(players, tableCards, offset, game, round)
      print("\r   Waiting for other to play 👑")
      sleep(1)
      print("\r👑 Waiting for other to play   ")
      gameCycle(tableCards, players, game, round)
      return
    else
      printstyled(player.name * " cards:\n", color=:cyan)
      printCards(player)
      index = request("Select card: ", RadioMenu(map((card) -> rank_names[card.rank] * suit_names[card.suit], valids), pagesize=7, charset=:unicode))
    end
    run(`clear`)
    choosen = valids[index]

    push!(tableCards, choosen)
    filter!(e::Card -> e.suit ≠ choosen.suit || e.rank ≠ choosen.rank, player.deck.cards)

    if (!DEBUG && i != 4 && !ONLINE)
      showTable(players, tableCards, offset, game, round)
      println("Hand over to next player")
      readline()
      run(`clear`)
    end

    showTable(players, tableCards, offset, game, round)
    pushData(tableCards, players, game, round)
  else
    checkPoints(players, tableCards, offset, round, game)
    println()
    showTable(players, tableCards, offset, game, round)
    for player in players
      println(player.name * " points:" * string(player.points))
    end
    readline()
    run(`clear`)
    PLAYERINDEX == 1 && empty!(tableCards)
    if (round < 13)
      round += 1
    else
      game += 1
      round = 1
      PLAYERINDEX == 1 && handOutCards()
    end
    if (PLAYERINDEX == 1)
      pushData(tableCards, players, game, round)
    else
      tableCards, players, game, round = syncData()
    end
  end

  gameCycle(tableCards, players, game, round)
end

init()

println("done")
readline()