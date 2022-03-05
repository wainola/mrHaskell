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
