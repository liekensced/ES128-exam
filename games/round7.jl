#Ronde met troef, MOMENTEEL NOG NIET IN ORDE!!!
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
  players[(currentWinner+offset+3)%4+1].points -=  1
end

function troef(card.suit)
  for cards in card
    if card.suit in troef
      
      