module Main where
  import System.Environment (getArgs)
  import Text.Printf (printf)

  readNumbersFromCommand :: String -> [String] -> Int
  readNumbersFromCommand operation listNumbers
    | operation == "+" = sum toIntStrings
    | operation == "*" = product toIntStrings
    | operation == "-" = foldl (-) 0 toIntStrings
    | otherwise = 0
    where
      toIntStrings = map (\s -> read s :: Int) listNumbers

  main :: IO ()
  main = do
    (op: nums) <- getArgs
    printf "The result of the number is %d" (readNumbersFromCommand op nums)
