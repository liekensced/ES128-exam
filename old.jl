function readInt(msg::String, max::Int64)
  print(msg)
  id::Int64 = 0
  try
    id = parse(Int64, readline())
  catch
    println("Please enter a valid number")
    return readInt(msg,max)
  end
  if(id>max)
    println("The maximum is $max")
    return readInt(msg,max)
  end
  return id
end