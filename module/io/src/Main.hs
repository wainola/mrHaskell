module Main where
  import System.IO (openFile, IOMode(ReadMode), hGetContents)
  import Text.Read
  import System.Environment (getArgs)

  andThen :: IO a -> (a -> IO b) -> IO b
  andThen = (>>=)

  newIO :: a -> IO a
  newIO = undefined

  ioRead:: String -> IO Int
  ioRead numString = return (read numString)

  ioShow :: Int -> IO String
  ioShow = return . show

  doSomeFileStuff =
    openFile "../foo.txt" ReadMode
    >>= hGetContents
    >>= putStrLn

  showWhitSeq :: IO ()
  showWhitSeq =
    putStrLn  "this is just some text"
    >> putStrLn "there are many lines of it"
    >> putStrLn "not one a new function"

  sumArgs :: [String] -> Maybe Int
  sumArgs strArgs =
    let intArgs = mapM readMaybe strArgs in fmap sum intArgs

  copyFile :: FilePath -> FilePath -> IO ()
  copyFile src dst = (readFile src) `andThen` (writeFile dst)

  transformArgs [] = ""
  transformArgs (x:xs) = x ++ " " ++ transformArgs xs

  countArgs listStr = foldl (\acc _ -> (+) acc 1) 0 listStr

  -- longCopy :: FilePath -> FilePath -> IO ()
  -- longCopy src dst =
  --   openFile src ReadMode `andThen`
  --   hGetContents `andThen`
  --   \contents ->
  --     openFile dst WriteMode `andThen`
  --     flip hPutStr contents

  main :: IO ()
  main = do
    putStrLn "Get me some args"
    args <- getArgs
    let argsTransformed = transformArgs args
    print argsTransformed
    let argumentsInserted = countArgs args
    print ("The number of arguments that you inserted where: " ++ show argumentsInserted)
    print (args !! 0)
    let (Just a) = sumArgs args
    print a
