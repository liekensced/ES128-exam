const HelpMessages = ["No Tricks", "No Hearts", "No Men", "No Queens", "No Heart King", "Not 7th or last Trick", "Troef"]


function tableCardsStrings(tableCards::Array{Card}, i::Int64)::String
  if (length(tableCards) < i)
    return "*"
  end
  return card2str(tableCards[i])
end

function showTable(players::Array{Player}, tableCards::Array{Card}, offset::Int64, game::Int64, round::Int64)
  if (isWindows || true)
    tabLength = 8
  else
    tabLength = 4
  end
  println("*" * "="^(4 * tabLength) * "*" * "\t Game $game")
  println("|\t\t\t\t |\t Round $round")
  print("|\t\t" * tableCardsStrings(tableCards, tweakedIndex(1, offset)) * "\t\t |\t ")
  printstyled(HelpMessages[game] * "\n", color=:cyan)
  println("|\t" * tableCardsStrings(tableCards, tweakedIndex(2, offset)) * "\t\t" * tableCardsStrings(tableCards, tweakedIndex(4, offset)) * "\t |")
  println("|\t\t" * tableCardsStrings(tableCards, tweakedIndex(3, offset)) * "\t\t |")
  println("|\t\t\t\t |")
  println("*" * "="^(4 * tabLength) * "*")
  println()
end


