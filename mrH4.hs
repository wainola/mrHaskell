isEventAdd2 :: Integer -> Maybe Integer
isEventAdd2 n = if even n then Just (n + 2) else Nothing

-- SMART CONSTRUCTORS USING MAYBE MONAD
type Name = String
type Age = Integer

data Person = Person Name Age deriving Show

makePerson :: Name -> Age -> Maybe Person
makePerson name age
    | name /= "" && age >= 0 = Just $ Person name age
    | otherwise = Nothing

-- USING EITHER MONAD
data PersonInvalid = NameEmpty | AgeTooLow deriving (Eq, Show)

toString :: PersonInvalid -> String
toString NameEmpty = "NameEmpty"
toString AgeTooLow = "AgeTooLow"

makePerson2 :: Name -> Age -> Either PersonInvalid Person
makePerson2 name age
    | name /= "" && age >= 0 = Right $ Person name age
    | name == "" = Left NameEmpty
    | otherwise = Left AgeTooLow

type ValidatePerson a = Either [PersonInvalid] a

ageOkay :: Age -> Either [PersonInvalid] Age
ageOkay age = case age >= 0 of
    True -> Right age
    False -> Left [AgeTooLow]

nameOkay :: Name -> Either [PersonInvalid] Name
nameOkay name = case name /= "" of
    True -> Right name
    False -> Left [NameEmpty]

makePerson3 :: Name -> Age -> ValidatePerson Person
makePerson3 name age = makePerson' (nameOkay name) (ageOkay age)

makePerson' :: ValidatePerson Name -> ValidatePerson Age -> ValidatePerson Person
makePerson' (Right nameOk) (Right ageOk) = Right (Person nameOk ageOk)
makePerson' (Left badName) (Left badAge) = Left (badName ++ badAge)
makePerson' (Left badName) _ = Left badName
makePerson' _ (Left badAge) = Left badAge

-- SOME STRING PROCESSING WITH MAYBE
notThe :: String -> Maybe String
notThe str = if "the" `elem` words str then Nothing else Just str

replaceThe = (\x -> if x == "the" then "a" else x)

replaceAndTransform str = case notThe str of
    (Just str) -> "bad word"
    Nothing -> unwords $ map replaceThe (words str)

vocals = ['a', 'e', 'i', 'o', 'u']

-- countBeforeVowel :: String -> Int -> Int
countBeforeVowel str counter = let worded = words str
                                   (h:t) = worded in
                                       if h == "the" && head t !! 0 `elem` vocals
                                           then
                                               let uw = unwords t
                                                   c = (+1) counter
                                                in countBeforeVowel uw c
                                            else
                                                if h /= "the" && h == "the"
                                                    then
                                                        let uw = unwords t
                                                        in countBeforeVowel uw counter
                                                    else
                                                        show counter

extractVowels str = filter (\x -> x `elem` vocals) str
extractConsonants str = filter (\x -> not (x `elem` vocals) && x /= ' ') str
countVowels str = length $ extractVowels str

newtype Word' = Word' String deriving (Eq, Show)

mkWord :: String -> Maybe Word'
mkWord str = let lengthVowesl = length $ extractVowels str
                 lengthConsonants = length $ extractConsonants str
                 in if lengthVowesl > lengthConsonants then Nothing else Just (Word' str)

isJust :: Maybe a -> Bool
isJust (Just a) = True
isJust _ = False

isNothing :: Maybe a -> Bool
isNothing Nothing = True
isNothing (Just a) = False

mayybee :: b -> (a -> b) -> Maybe a -> b
mayybee x func Nothing = x
mayybee x func (Just a) = func a

listToMaybe :: [a] -> Maybe a
listToMaybe [] = Nothing
listToMaybe (x:_) = Just x

maybeToList :: Maybe a -> [a]
maybeToList Nothing = []
maybeToList (Just a) = [a]
