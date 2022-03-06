data CheckIsEven = String | Bool deriving Show
type ValidEven a = Either [CheckIsEven] a

checkIsEven :: Maybe Int -> Either String Bool
checkIsEven Nothing  = Left "Nothing"
checkIsEven (Just a) = if a `mod` 2 == 0 then Right True else Left "Nothing"

safeDiv :: Float -> Float -> Either String Float
safeDiv x 0 = Left "Divison by zero"
safeDiv x y = Right (x / y)

type Number = Int
type Message = String
type TheTruth = Bool
data ValidEven' = Message | TheTruth deriving Show

toString :: ValidEven' -> String
toString Message = "Not even and but multiply of 3"
toString TheTruth = "Sadly nothing"

isEven :: Int -> Either [ValidEven'] Number
isEven num = if num `mod` 2 == 0 then Right num else
    if num `mod` 3 == 0 then Left [Message] else Left [TheTruth]
