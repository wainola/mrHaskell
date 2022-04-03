module Main where
  import System.Environment (getArgs)
  import Text.Printf (printf)

  readNumbersFromCommand :: [String] -> Int
  readNumbersFromCommand listNumbers =
    let toIntStrings = map (\s -> read s :: Int) listNumbers
    in sum toIntStrings

  main :: IO ()
  main = do
    args <- getArgs
    printf "The result of the number is %d" (readNumbersFromCommand args)
