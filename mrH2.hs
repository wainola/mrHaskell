data DayOfTheWeek = Mon | Tue | Weds | Thu | Fri | Sat | Sun

data Date = Date DayOfTheWeek Int

instance Eq DayOfTheWeek where
    (==) Mon Mon = True
    (==) Tue Tue = True
    (==) Weds Weds = True
    (==) Thu Thu = True
    (==) Fri Fri = True
    (==) Sat Sat = True
    (==) Sun Sun = True
    (==) _ _ =  False

instance Eq Date where
    (==) (Date weekDay dayOfTheMonth)
         (Date weekDay' dayOfTheMonth') = weekDay == weekDay' && dayOfTheMonth == dayOfTheMonth'

-- testing
sameDate :: Bool
sameDate = Date Thu 10 == Date Thu 10

notSameDate :: Bool
notSameDate = Date Thu 10 == Date Thu 11

data Identity a = Identity a
--  HERE a HAS A INSTANCE OF EQ BEFORE GOING TO THE TYPECLASS IDENTITY
instance Eq a => Eq (Identity a) where
    (==) (Identity v) (Identity v') = v == v'

-- data TisAnInteger = TisAn Integer
-- instance Eq a => Eq (TisAnInteger a) where
--     (==) (TisAn v) (TisAn v') = v == v'

class BasicEq a where
    isEqual :: a -> a -> Bool

instance BasicEq Bool where
    isEqual True True = True
    isEqual False False = True
    isEqual _ _ = False

-- FOR THIS CLASS AT LEAST ONE FUNCTION MUST BE IMPLEMENTED
class BasicEq3 a where
    isEqual3 :: a -> a -> Bool
    isEqual3 x y = not (isNotEqual3 x y)

    isNotEqual3 :: a -> a -> Bool
    isNotEqual3 x y = not (isEqual3 x y)
