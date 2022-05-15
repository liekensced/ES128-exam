#round 2 minste harten
function hearts()
  for round in 1:2
    for Player.cards[i] in cards.deck
      if Player.cards.suit[i] = ♡
        Player.points = -1


# Gets the 4 cards on the table
# Cards[1] belongs to players[1]
# to change points: players[i].points = players[i].points - 1

function checkPoints(cards, offset, round::Int64, game::Int64)
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

#currentCards::Array{Card} but that throws error
function validCards(cards::Array{Card}, currentCards)::Array{Card}

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
    