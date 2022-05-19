# Has to return the index of the valid cards !
# table of type Array{Card}

function botPlay(cards::Array{Card}, table::Array)::Int64
  valids = validCards(cards, table)

  if (length(table) == 0)
    DEBUGBOT && println("Bot: random card")
    DEBUGBOT && readline()
    return min(valids)[2]
    #return Random.rand(1:length(valids)) #alternative
  end

  # The bot has not cards of the current suit
  if(valids[1].suit != table[1].suit)
    return max(valids)[2]
  end

  highestTableCard::Card = max(table)[1]
  highestrank::Int64 = 0
  index::Int64 = 0
  
  for (i, card) in enumerate(valids)
    if (highestTableCard.rank>card.rank)
      if (highestrank < card.rank)
        highestrank = card.rank
        index = i
      end
    end
  end

  # The bot has no card lower than the current highest (loses)
  if (index==0)
    if(length(table) == 3)
      index = max(valids)[2]
    else
      index = min(valids)[2]
    end
  end
  return index
end

function min(cards::Array)
  lowest::Card = cards[1]
  i::Int64 = 0
  for card in cards
    i += 1
    if (card.rank < lowest.rank)
      lowest = card
    end
  end
  return (lowest, i)
end

function max(cards::Array)
  highest::Card = cards[1]
  i::Int64 = 0
  for card in cards
    i += 1
    if (card.rank > highest.rank)
      highest = card
    end
  end
  return (highest, i)
end