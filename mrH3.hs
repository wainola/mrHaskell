isItTwo :: Integer -> Bool
isItTwo 2 = True
isItTwo _ = False

-- USING HERE NEWTYPE KEYWORD THAT ALLOWS ONLY ONE CONSTRUCTOR
-- AND JUST ONE FIELD

newtype Username = Username String
newtype AccountNumber = AccountNumber Integer

data User = UnregisteredUser | RegisteredUser Username AccountNumber

printUser :: User -> IO ()
printUser UnregisteredUser = putStrLn  "UnregisteredUser"
-- HERE WE USE PATTERN MATCHING TO ACCESS THE TYPES
-- THATA WERE INITIALIZED BY THE NEWTYPES
printUser (
    RegisteredUser
    (Username name)
    (AccountNumber acctNum)) = putStrLn $ name ++ " " ++ show acctNum

newtype UserList = UserList [User]

data Users = Users UserList

u1 = RegisteredUser (Username "sauron") (AccountNumber 6633)
u2 = RegisteredUser (Username "melkor") (AccountNumber 4456)
u3 = RegisteredUser (Username "elrond") (AccountNumber 7788)

users = Users (UserList [u1, u2, u3])

(Users (UserList (xx:_))) = users
(RegisteredUser (Username n) (AccountNumber acc)) = xx
nn = n
aa = acc

getOneUser :: Int -> IO ()
getOneUser id = let (Users (UserList uList)) = users
                    uItem = uList !! id
                    (RegisteredUser (Username name) (AccountNumber account)) = uItem
                    in putStrLn $ "name: " ++ name ++ " -> account: " ++ show account

--  SECOND ATTEMP TO USE PATTERN MATCHING
data Users1 = Users1 [User]

users1 = Users1 [u1, u2, u3]

(Users1 (x:_)) = users1
(RegisteredUser (Username name) (AccountNumber acct)) = x
firstUsername = name
firstUserAccountNumber = acct

getOnById idx = let (Users1 users) = users1
                    (RegisteredUser (Username name) (AccountNumber acct)) = users !! idx
                    in (acct, name)

-- SOME ITERATIONS OVER USERS
transformToTuple (
    RegisteredUser (Username name) (AccountNumber acct)) = (acct, name)

iterateAndTransform = let (Users1 users) = users1 in map transformToTuple users

iterateAndTransform' :: Users1 -> [(Integer, String)]
iterateAndTransform' (Users1 users) = map transformToTuple users

flattened :: [(Integer, String)]
flattened = iterateAndTransform' users1

getTupleById :: Integer -> (Integer, String)
getTupleById id = head $ filter (\x -> fst x == id) flattened

addElement :: (Integer, String) -> [(Integer, String)]
addElement tup = tup : flattened

-- SOME NOTES ON NEWTYPE KEYWORD
tooManyGoats :: Int -> Bool
tooManyGoats n = n > 42

newtype Goats = Goats Int deriving (Eq, Show)
newtype Cors = Cows Int deriving (Eq, Show)

tooManyGoatsRW :: Goats -> Bool
tooManyGoatsRW (Goats n) = n > 42

-- HERE WE DEFINE A TYPE CLASS WITH TOOMANY METHOD TO BE DEFINED
-- OVER SOME TYPES
class TooMany a where
    tooMany :: a -> Bool

-- TOOMANY IMPLEMENTATION OVER INT TYPE
instance TooMany Int where
    tooMany n = n > 42

-- UNARY TYPE GOATS2
newtype Goats2 = Goats2 Int deriving Show

-- TOOMANY IMPLEMENTATION OVER GOATS WITH PATTERN MATCHING OVER IN THE METHOD
instance TooMany Goats2 where
    tooMany (Goats2 n) = n > 43

class TooMany2 a where
    tooMany2 :: a -> Bool

instance TooMany2 Int where
    tooMany2 n = n > 42

newtype Goats3 = Goats3 Int deriving (Eq, Show)

-- HERE THE GOATS INSTANCE IS GOING TO DO THE SAME THAT IS ALREADY
-- DEFINED IN THE TOOMANY2 METHOD
instance TooMany2 Goats where
    tooMany2 (Goats n) = tooMany2 n

-- RECORD SYNTAX FOR TYPE DEFINITION
-- THE ADVANTAGE OF THIS IS THE DEFINITION OF
-- NAMED PROPERTIES THAT BEHAVES AS GETTERS
data Person = Person {
    pname :: String,
    age :: Int
} deriving (Eq, Show)

p1 = Person "John" 33
p2 = Person "Mike" 34

data OperatingSystem =
    GnuPlusLinux
    | OpenBSDJustBSD
    | Mac
    | Windows
    deriving (Eq, Show)

data ProLang =
    Haskell
    | Agda
    | Idris
    | PureScript
    deriving (Eq, Show)

data Programmer =
    Programmer {
        os:: OperatingSystem,
        lang :: ProLang
    } deriving (Eq, Show)

sillyProgrammer :: Programmer
sillyProgrammer = Programmer { os = Mac, lang = Idris }

masterOfAll :: Programmer
masterOfAll = Programmer { os = GnuPlusLinux, lang = Haskell }

getOs programmer = os programmer

-- SOME EXTENSIONS OF DECONSTRUCTING VALUES

newtype Name = Name String deriving Show
newtype Acres = Acres Int deriving Show

data FarmerType = DairyFarmer
                  | WheatFarmer
                  | SoybeanFarmer
                  deriving Show

data Farmer = Farmer Name Acres FarmerType deriving Show

-- UNPACKING DATA
isDairyFarmer :: Farmer -> Bool
isDairyFarmer (Farmer _ _ DairyFarmer) = True
isDairyFarmer _ = False

data FarmerRec = FarmerRec {
    farmerName :: Name,
    acres :: Acres,
    farmerType :: FarmerType
} deriving Show

-- UNPACKING USING CASE AND GETTERS FROM RECORD CREATION
isDairyFarmer2 :: FarmerRec -> Bool
isDairyFarmer2 farmer =
    case farmerType farmer of
        DairyFarmer -> True
        _           -> False

