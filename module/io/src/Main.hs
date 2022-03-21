module Main where

  andThen :: IO a -> (a -> IO b) -> IO b
  andThen = undefined

  copyFile :: FilePath -> FilePath -> IO ()
  copyFile src dst = (readFile src) `andThen` (writeFile dst)

  -- longCopy :: FilePath -> FilePath -> IO ()
  -- longCopy src dst =
  --   openFile src ReadMode `andThen`
  --   hGetContents `andThen`
  --   \contents ->
  --     openFile dst WriteMode `andThen`
  --     flip hPutStr contents

  main :: IO ()
  main = do
    putStrLn "hello world"
