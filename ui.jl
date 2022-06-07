const HelpMessages = ["No Tricks","No Hearts","No Men","No Queens","No Heart King","Not 7th or last Trick","Troef"]


function tableCardsStrings(i::Int64)::String
  if (length(tableCards) < i)
    return "*"
  end
  return card2str(tableCards[i])
end

  function showTable(offset::Int64, game::Int64, round::Int64)
    if (isWindows)
      tabLength = 8
    else
      tabLength = 4
    end
    println("*"*"="^(4*tabLength)*"*"*"\t Game $game")
    println("|\t\t\t\t |\t Round $round")
    print("|\t\t"*tableCardsStrings(tweakedIndex(1,offset))*"\t\t |\t ")
    printstyled(HelpMessages[game]*"\n", color=:cyan)
        println("|\t"*tableCardsStrings(tweakedIndex(2,offset))*"\t\t"*tableCardsStrings(tweakedIndex(4,offset))*"\t |")
      println("|\t\t"*tableCardsStrings(tweakedIndex(3,offset))*"\t\t |")
    println("|\t\t\t\t |")
    println("*"*"="^(4*tabLength)*"*")
    println()
  end

function printking()
  print("""
               _
   _       _ _(_)_    _   _  _
  (_)     | (_) (_)  | | / /(_)        ___
   _ _   _| |_  __ _ | |/ /  _ _    _ / __|
  | | | | | | |/ _` ||   (  | |  \\ | | /  _
  | | |_| | | | (_| || |\\ \\ | | |\\\\| | |_| |
 _/ |\\__'_|_|_|\\__'_|| | \\ \\|_|_| \\__|\\____/
|__/                 |_|  \\_\\                      \n\n""")
end