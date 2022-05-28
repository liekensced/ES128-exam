function checkPoints4(players, cards, offset, round::Int64, game::Int64)
  currentSuit = cards[1].suit
  currentHighest = 0
  currentWinner = 0
  
  for i in 1:4
    if(cards[i].rank > currentHighest && cards[i].suit == currentSuit)
        currentHighest = cards[i].rank
        currentWinner = i
    end
  end
  players[(currentWinner+offset+3)%4+1].points -=  dames(cards)
end

function dames(cards)
  i = 0
  for card in cards
    if card.rank == 11
      i += 2
    end
  end
  return i
end