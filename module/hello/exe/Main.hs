module Main (main) where
import DogsRule
import Hello
import System.IO

main :: IO ()
main = do
  hSetBuffering stdout NoBuffering
  putStr "Please input your name: "
  name <- getLine
  sayHello name
  dogs
  c <- getChar
  c' <- getChar
  if c == c' then putStrLn "True" else return ()
