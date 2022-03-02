module TopOrLocal where

    topLevelFunction :: Integer -> Integer
    topLevelFunction x =
        x + woot + topLevelValue
        where woot :: Integer
              woot = 10

    topLevelValue :: Integer
    topLevelValue = 5

    ids :: [Int]
    ids = [1..5]

    names :: [String]
    names = ["frank", "isaac", "john", "marcus", "leon"]

    namesAndIds :: [(Int, String)]
    namesAndIds = zip ids names

    getTupleByIndex :: Int -> (Int, String)
    getTupleByIndex idx = namesAndIds !! idx

    getFst t = fst t

    getTupleById :: Int -> (Int, String)
    getTupleById id = head $ filter (\x
                                        -> let first = fst x in first == id) namesAndIds

    mapAndTransform :: Int -> (Int, String) -> (Int, String)
    mapAndTransform = (\id -> \x -> let first = fst x in  if first == id then x else (0, "nothing"))

    filterAndRetunrTuple :: (Int, String) -> Bool
    filterAndRetunrTuple =(\y -> let first = fst y in first /= 0)

    getTupleByIdOrEmptyTuple :: Int -> (Int, String)
    getTupleByIdOrEmptyTuple id = head $ filter filterAndRetunrTuple $ map (mapAndTransform id) namesAndIds

    foo param =
        (\x
            -> let y = x + 1
                   z = x + 2
                   in y + z) param

    fee arr = map (\x
                        -> let first = fst x
                               in first + 1) arr

    faa arr = filter (\x -> let first = fst x in first == 2) arr

    text = "this is a word"
    wordsSplited = words text
