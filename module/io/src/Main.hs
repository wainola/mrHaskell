module Main where
  import System.IO (openFile, IOMode(ReadMode), hGetContents)
  import Text.Read ( readMaybe )
  import System.Environment (getArgs)
  import Text.Printf (printf)

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

  lazyIODemo :: IO ()
  lazyIODemo =
    let sayHello :: IO ()
        sayHello = putStrLn "Hello"
        raiseAMathError :: IO Int
        raiseAMathError = putStrLn "I'm part of raiseAMathError" >> return (1 `div` 0)
    in sayHello
    >> raiseAMathError
    >> sayHello

  -- longCopy :: FilePath -> FilePath -> IO ()
  -- longCopy src dst =
  --   openFile src ReadMode `andThen`
  --   hGetContents `andThen`
  --   \contents ->
  --     openFile dst WriteMode `andThen`
  --     flip hPutStr contents

  makeAndShow :: Int -> IO ()
  makeAndShow n = makeAndReadFile n >>= putStrLn

  makeAndReadFile :: Int -> IO String
  makeAndReadFile fnumber =
    let fname = printf "../%d" fnumber
    in writeFile fname fname >> readFile fname

  unsafe :: IO ()
  unsafe =
    let files = mapM makeAndReadFile [1..5000] :: IO [String]
    in files >>= (putStrLn . show)

  safe :: IO ()
  safe = foldl (\io id -> io >> makeAndShow id) (return ()) [1..500]

  safe' :: IO ()
  safe' = mapM_ makeAndShow [1..500]

  main :: IO ()
  main = do
    putStrLn "Get me some args"
    args <- getArgs
    let argsTransformed = transformArgs args
    print argsTransformed
    let argumentsInserted = countArgs args
    print ("The number of arguments that you inserted where: " ++ show argumentsInserted)
    -- print (args !! 0)
    -- let (Just a) = sumArgs args
    -- print a
    lazyIODemo
    unsafe
