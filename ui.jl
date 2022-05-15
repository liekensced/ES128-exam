function tableCardsStrings(i::Int64)
  if (length(tableCards) < i)
    return "*"
  end
  return card2str(tableCards[i])
end

function showTable(offset::Int64)
  println("\t\t"*tableCardsStrings(tweakedIndex(1,offset)))
      println("\t"*tableCardsStrings(tweakedIndex(2,offset))*"\t\t"*tableCardsStrings(tweakedIndex(4,offset)))
    println("\t\t"*tableCardsStrings(tweakedIndex(3,offset)))
end


