import Base.isless

const suit_names = ["♢", "♡", "♠","♣"];
const rank_names= ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "1"];

struct Card
	suit::Int64
	rank::Int64
	function Card(suit::Int64, rank::Int64)
		@assert(1 ≤ suit ≤ 4, "suit is not between 1 and 4")
		@assert(1 ≤ rank ≤ 13, "rank is not between 1 and 13")
		new(suit, rank)
	end
end


function Base.show(io::IO, card::Card)
	print(io, rank_names[card.rank], suit_names[card.suit])
end

function card2str(card::Card)
  return rank_names[card.rank]*suit_names[card.suit]
end

function isless(c1::Card, c2::Card)
	(c1.suit, c1.rank) < (c2.suit, c2.rank)
	end

mutable struct Deck
	cards::Array{Card}
end
	
function fullDeck()
	deck = Deck(Card[])
  
	for suit in 1:4
		for rank in 1:13
     
			push!(deck.cards, Card(suit, rank))
		end
	end
  return deck
end

function handOutCards()
  shuffle!(currentDeck.cards)
  for i in 1:4
    index = (i-1)*13
    players[i].deck.cards = currentDeck.cards[index + 1: index + 13]
  end
  run(`clear`)
end