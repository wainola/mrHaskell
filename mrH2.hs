import qualified Data.List
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

data Color = Red | Green | Blue
instance BasicEq3 Color where
    isEqual3 Red Red = True
    isEqual3 Green Green = True
    isEqual3 Blue Blue = True
    isEqual3 _ _ = False

instance Show Color where
  show Red = "Red"
  show Green = "Green"
  show Blue = "Blue"

c1 :: Color
c1 = Red
c2 :: Color
c2 = Blue
c3 :: Color
c3 = Red

sameColor = isEqual3 c1 c3
notSameColor = isEqual3 c1 c2

-- DERIVATIONS
data ColorD = RedD | GreenD | BlueD deriving (Read, Show, Eq, Ord)

showed = show RedD
readed = (read "BlueD")::ColorD

sameColorD = RedD == RedD
notSameColoD = RedD == BlueD

gt = RedD < GreenD

data TwoIntegers = Two Integer Integer deriving (Eq, Show, Read)

-- APPLICATIONS OF DERIVATIONS
d1 = show (Two 1 2)
d2 = (read "Two 22 33")::TwoIntegers
d3 = Two 11 2 == Two 11 2
d4 = Two 11 2 == Two 1 3
d5 = Two 23 56 /= Two 1 9

data TisAnInteger = TisAn Integer deriving (Eq, Ord, Show)

s1 = Data.List.sort [TisAn 22, TisAn 11, TisAn 56, TisAn 100, TisAn 98]
s2 = TisAn 11 > TisAn 1
s3 = compare (TisAn 23) (TisAn 72)
s4 = max (TisAn 15) (TisAn 100)

data Tuple a = Pair a a deriving (Eq)

t1 = Pair 1 3
t2 = Pair 2 3
t3 = Pair 1 3

t4 = t1 == t3
t5 = t2 /= t3

type Subject = String
type Verb = String
type Object = String

data Sentence = Sentence Subject Verb Object deriving (Eq, Show)

sentence1 = Sentence "some funk" "less typo" "this is an object"
sentence2 = Sentence "oliver" "atom" "funny"

type Id = Int
type Name = String
type Lastname = String
type Age = Int
type Hobbies = [(Int, String)]

data Person = Person Id Name Lastname Age Hobbies deriving (Show)

person1 = Person 1 "John" "Wick" 34 [
    (1, "Shooting"),
    (2, "Fighting crime"),
    (3, "Driving cars")]

type People = [Person]
