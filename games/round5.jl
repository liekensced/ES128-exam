function checkPoints5(cards, offset, round::Int64, game::Int64)
  currentSuit = cards[1].suit
  currentHighest = 0
  currentWinner = 0
  
  for i in 1:4
    if(cards[i].rank > currentHighest && cards[i].suit == currentSuit)
        currentHighest = cards[i].rank
        currentWinner = i
    end
  end
  players[(currentWinner+offset+3)%4+1].points -=  hheer(cards)
end

function hheer(cards)
  i = 0
  for card in cards
    if card.rank == 12 && card.suit == 2
      i += 5
    end
  end
  return i
end