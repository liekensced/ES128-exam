
# Gets the 4 cards on the table
# Cards[1] belongs to players[1]
# to change points: players[i].points = players[i].points - 1

function checkPoints(cards::Array, offset::Int64, round::Int64, game::Int64)
  if (game == 6)
    if (round != 7||round !=13)
      return
    end
  end
  
  if (game == 5)
        checkPoints5(cards, offset, round, game)
    return
  end
  
  if (game == 4)
    checkPoints4(cards, offset, round, game)
    return
  end
  
  if (game == 3)
    checkPoints3(cards, offset, round, game)
    return
  end 
  
  if(game == 2)
    checkPoints2(cards, offset, round, game)
    return
  end

  currentSuit = cards[1].suit
  currentHighest = 0
  currentWinner = 0
  
  for i in 1:4
    if(cards[i].rank > currentHighest && cards[i].suit == currentSuit)
        currentHighest = cards[i].rank
        currentWinner = i
    end
  end
    players[(currentWinner+offset+3)%4+1].points -= 1
    
end

