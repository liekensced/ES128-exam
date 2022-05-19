
mutable struct Player
  name::String
  points::Int64 # negative points are penalty points
  deck::Deck 
  function Player(n::String)
    new(n,0,Deck(Card[]))
  end
end

function printCards(p::Player)
  i::Int64 = 0
  for card in p.deck.cards
    if(card.suit<3)
      printstyled(card, bold=true, color=:red)
    else
      printstyled(card, bold=true)
    end
    print("\t")
  end
  println()
end

function validCards(cards::Array, currentCards::Array)::Array
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