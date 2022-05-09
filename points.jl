# Gets the 4 cards on the table
# Cards[1] belongs to players[1]
# to change points: players[i].points = players[i].points - 1

function checkPoints(cards::Array{Card})
  currentSuit = cards[1].suit
  
end

function validCards(cards::Array{Card}, currentCards)

  if(isempty(currentCards))
    return cards
  end
  currentSuit = currentCards[1].suit
  valids::Array{Card} = []
  
  for card in cards
    if (card.suit == currentSuit)
      push!(valids, card)
    end
  end
  
  if(isempty(valids))
    return cards
  end
  
  return valids
end