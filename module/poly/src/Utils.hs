module Utils
  (
    emptyString,
    checkFirstName,
    checkLastname,
    checkLevel,
    checkAge,
    addEssay,
  )
where
    import Definitions (Essays (Essays))

    emptyString :: String -> Maybe Bool
    emptyString s
        | s == "" = Nothing
        | otherwise = Just True

    checkFirstName :: String -> Either Bool String
    checkFirstName s = case emptyString s of
        Nothing -> Left False
        _ -> Right s

    checkLastname :: String -> Either Bool String
    checkLastname s = case emptyString s of
        Nothing -> Left False
        _ -> Right s

    checkLevel :: String -> Either (Maybe a) String
    checkLevel s = case emptyString s of
        Nothing -> Left Nothing
        _ -> Right s

    checkAge :: Int -> Either (Maybe a) Int
    checkAge a
        | a == 0 = Left Nothing
        | otherwise = Right a

    addEssay :: Essays -> [Essays] -> [Essays]
    addEssay essay essays = essay : essays
