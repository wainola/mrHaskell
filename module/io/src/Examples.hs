module Examples where
    import GHC.IO.IOMode (IOMode(ReadMode))
    import System.IO (hGetContents, openFile)

    ioRead :: String -> IO Int
    ioRead numString = return (read numString)

    -- CHAINING THE RESULT OF IOREAD
    ioShow :: Int -> IO String
    ioShow = return . show

    ioSucc :: Int -> IO Int
    ioSucc = return . succ

    doSomeFileStuff =
        openFile "./foo.txt" ReadMode
        >>= hGetContents
        >>= putStrLn

    someStuff :: String -> Maybe String
    someStuff str = Just ("the stuff was: " ++ str)

    otherStuff :: String -> Maybe String
    otherStuff str = Just (str ++ " <- was the previous stuff")

    resultBinded = someStuff "lambda" >>= otherStuff

    maybe1 :: String -> Maybe String
    maybe1 "" = Nothing
    maybe1 str = Just str

    maybe2 :: String -> Maybe [String]
    maybe2 "" = Nothing
    maybe2 str = Just [str]

    maybe3 :: [String] -> Maybe String
    maybe3 [] = Nothing
    maybe3 (x:_)
        | x == "foo" = Just ("The value was: " ++ x)
        | otherwise = Just "I was expecting bar"

