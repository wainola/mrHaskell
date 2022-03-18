data CustomerInfo = CustomerInfo String String Int Int
customerGeorge :: CustomerInfo
customerGeorge = CustomerInfo "Georgie" "Bird" 10 100

showCustomer :: CustomerInfo -> String
showCustomer (CustomerInfo first last count balance) =
    let fullname = first <> " " <> last
        name = "name: " <> fullname
        count' = "count: " <> (show count)
        balance' = "balance: " <> (show balance)
    in name <> " " <> count' <> " " <> balance'


applyDiscount :: CustomerInfo -> CustomerInfo
applyDiscount customer =
    case customer of
        (CustomerInfo "Georgie" "Bird" count balance) -> CustomerInfo "Georgie" "Bird" count (balance `div` 4)
        (CustomerInfo "Porter" "Pupper" count balance) -> CustomerInfo "Porter" "Pupper" count (balance `div` 2)
        otherCustomer -> otherCustomer

firstName :: CustomerInfo -> String
firstName (CustomerInfo name _ _ _ ) = name
lastName :: CustomerInfo -> String
lastName (CustomerInfo _ lastname _ _ ) = lastname
widgetCount :: CustomerInfo -> Int
widgetCount (CustomerInfo _ _ count _) = count
balance :: CustomerInfo -> Int
balance (CustomerInfo _ _ _ balance) = balance

updateFirstName :: CustomerInfo -> String -> CustomerInfo
updateFirstName (CustomerInfo _ lastname count balance) firstName = CustomerInfo firstName lastname count balance

-- USING RECORD NOTATION
data CustomerInfo' = CustomerInfo' {
    firstname :: String,
    lastname :: String,
    count :: Int,
    balance' :: Int
}

customerHarry = CustomerInfo' { balance' = 100, lastname = "Potter", firstname = "Harry", count = 10 }

customerFactory :: String -> String -> CustomerInfo'
customerFactory fname lname = CustomerInfo' {
    balance' = 0,
    count = 5,
    firstname = fname,
    lastname = lname
}

-- UPDATING RECORDS USING RECORD SINTAX
emptyCart :: CustomerInfo' -> CustomerInfo'
emptyCart customer = customer { balance' = 0, count = 0 }

getBalance' :: CustomerInfo' -> Int
getBalance' (CustomerInfo' _ _ _ bal ) = bal
