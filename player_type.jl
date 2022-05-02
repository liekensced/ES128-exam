
mutable struct Player
  name::String
  points::Int64 # negative points are penalty points
  deck::Deck #TODO type
  function Player(n::String)
    new(n,0,Deck(Card[]))
  end
end

function printCards(p::Player)
    i = 0
    for card in p.deck.cards
      i += 1
      printstyled("$i ", color=:blue)
      print(card)
      print("\t")
    end
  end

