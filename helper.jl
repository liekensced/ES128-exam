function pushData(tableCards, players, game::Int64, round::Int64)
    redirect_stdout(devnull) do
        d = Dict("tablecards" => tableCards, "players" => players, "round" => round, "game" => game)
        Firebase.realdb_put(PATH, d)
    end
end

function syncData()
    db = nothing
    redirect_stdout(devnull) do
        db = Firebase.realdb_get(PATH)
    end
    tableCards = map(c::Dict -> Card(c), Base.get(db, "tablecards", []))
    players = map(c::Dict -> Player(c), Base.get(db, "players", []))
    game = Base.get(db, "game", 0)
    round = Base.get(db, "round", 0)

    return (tableCards, players, game, round)
end

function structToDict(p)
    Dict(fieldnames(typeof(p)) .=> getfield.(Ref(p), fieldnames(typeof(p))))
end