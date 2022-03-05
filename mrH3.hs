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
