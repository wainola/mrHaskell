module Main where
  import Control.Monad.Writer
  import Control.Monad.Reader
  import Data.Maybe (fromMaybe)
  import System.Environment (lookupEnv)
  import qualified Data.Array as A
  import System.Random (StdGen)
  import Control.Monad.State


  maybeFunc1 :: String -> Maybe Int
  maybeFunc1 "" = Nothing
  maybeFunc1 str = Just $ length str

  maybeFunc2 :: Int -> Maybe Float
  maybeFunc2 i = if i `mod` 2 == 0
    then Nothing
    else Just ((fromIntegral  i) * 3.14159)

  maybeFunc3 :: Float -> Maybe [Int]
  maybeFunc3 f = if f > 15.0
    then Nothing
    else Just [floor f, ceiling f]

  runMaybeFuncs :: String -> Maybe [Int]
  runMaybeFuncs input = case maybeFunc1 input of
    Nothing -> Nothing
    Just i -> case maybeFunc2 i of
      Nothing -> Nothing
      Just f -> maybeFunc3 f

  runMaybeFuncsBind :: String -> Maybe [Int]
  runMaybeFuncsBind input = maybeFunc1 input >>= maybeFunc2 >>= maybeFunc3

  -- THIS IS IN CASE BIND DOESNT COMBINE WELL WITH THE DEFINITIONS OF OUR FUNCTIONS
  runMaybeFuncsDo :: String -> Maybe [Int]
  runMaybeFuncsDo input = do
    i <- maybeFunc1 input
    f <- maybeFunc2 i
    maybeFunc3 f

  -- IN CASE WE NEED TO RUN OPERATION AFTER UNWRAPING
  -- DO NOTATION IS NICE
  runMaybeFuncsDo2 :: String -> Maybe [Int]
  runMaybeFuncsDo2 input = do
    i <- maybeFunc1 input
    f <- maybeFunc2 (i + 2)
    maybeFunc3 f

  -- WE CAN DO IT WITH BIND WITH IT DOESNT LOOK CLEAN
  runMaybeFuncsBind2 :: String -> Maybe [Int]
  runMaybeFuncsBind2 input = maybeFunc1 input >>= (\i -> maybeFunc2 (i + 2)) >>= maybeFunc3

  -- READER AND WRITER MONADS
  instance Semigroup Int where
    a <> b = a + b

  instance Monoid Int where
    mempty = 0

  acc1 :: String -> (String, Int)
  acc1 input =
    if length input `mod` 2 == 0
      then runWriter (acc2 input)
      else runWriter $ do
        str1 <- acc3 (tail input)
        str2 <- acc4 (take 1 input)
        return (str1 ++ str2)

  acc2 :: String -> Writer Int String
  acc2 input = if (length input) > 10
    then do
      tell 1
      acc4 (take 9 input)
    else do
      tell 10
      return input

  acc3 :: String -> Writer Int String
  acc3 input = if (length input) `mod` 3 == 0
    then do
      tell 3
      acc2 (input ++ "ab")
    else do
      tell 1
      return $ tail input

  acc4 :: String -> Writer Int String
  acc4 input = if (length input) < 10
    then do
      tell (length input)
      return (input ++ input)
    else do
      tell 5
      return (take 5 input)

  -- l = [1..13]
  f :: String -> Writer Int String
  f input = (\e -> if (length e) `mod` 2 == 0
              then do
                tell 1
                return "just one"
              else do
                tell 2
                return "just two"
                ) input
  -- fmaped :: (Int String)
  -- fmaped = map f l

  ff :: String -> (String, Int)
  ff input = runWriter (f input)

  fii = (\e -> if e `mod` 2 == 0
          then do
            tell 1
            return ("was even: " ++ show e)
          else do
            tell 2
            return ("was odd: " ++ show e))

  fff :: Int -> (String, Int)
  fff num = runWriter (fii num)

  l = [1..20]
  fv = map (\e -> fff e) l


  -- STATE MONAD
  data GameState = GameState {
    board :: A.Array TileIndex TileState,
    currentPlayer :: Player,
    generator :: StdGen
  }

  data Plater = XPlayer | OPlayer

  data TileState = Empty | HasX | HasO deriving Eq

  type TileIndex = (Int, Int)

  chooseRandomMove :: State GameState TileIndex
  chooseRandomMove = undefined

  main :: IO ()
  main = do
    putStrLn "hello world"
