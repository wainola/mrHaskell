unique :: (a -> a -> Bool) -> [a] -> [a]
unique _ [] = []
unique f (elem:elems) =
    let
        f' a b = not $ f a b
        elems' = filter (f' elem) elems
    in elem : unique f elems'

-- THIS IS CUMBERSOME BECAUSE THE TYPE DEFINITION OF THE FUNCTION IS TOO LONG
sumOfUniques :: (a -> a -> a) -> (a -> a -> Bool) -> a -> [a] -> a
sumOfUniques add compare zero = foldr add zero . unique compare

-- POSIBLE SOLUTION: SET OF RELATED FUNCTIONS THAT WE CAN STORE IN RECORD NOTATION
data Natural a = Natural {
    equal :: a -> a -> Bool,
    add :: a -> a -> a,
    multiply :: a -> a -> a,
    additiveIdentity :: a,
    multiplicativeIdentity :: a
}

-- DEFINING VALUES THAT DEFINE OPERATIONS OVER VARIOUS TYPES
intNatural :: Natural Int
intNatural = Natural {
    equal = (==),
    add = (+),
    multiply = (*),
    additiveIdentity = 0,
    multiplicativeIdentity = 1
}

-- REWRITEN NATURAL RECORD AS A TYPECLASS
class Natural' n where
    equal' :: n -> n -> Bool
    add' :: n -> n -> n
    multiply' :: n -> n -> n
    additiveIdentity' :: n
    multiplicativeIdentity' :: n

-- THIS IS SIMILAR TO THE DEFINITION OF THE INTNATURAL RECORD DEFINITION
instance Natural' Int where
    equal' = (==)
    add' = (+)
    multiply' = (*)
    additiveIdentity' = 0
    multiplicativeIdentity' = 1

-- CUSTOM TYPECLASSES
class Animal n where
    feed :: n -> String
    walk :: n -> Int-> [Int]
    name :: n -> String

data Dog = Dog String String String [Int]

instance Animal Dog where
    feed (Dog _ foodName _ _ ) = "I eat " <> foodName
    walk (Dog  _ _ _ walked) newStep = newStep : walked
    name (Dog name _ _ _) = "My name is " <> name

-- COMPOSING TYPE CLASSES
class Animal n => Canine n where
    myBreed :: n -> String

instance Canine Dog where
    myBreed (Dog _ breed _ _ ) = "My breed is " <> breed

-- IMPLEMENTATIONS
bruno = Dog "Bruno" "Chihuahua" "Chicken" [1, 22]

whatIEat = feed bruno

myName = name bruno

walked = walk bruno 45

mybreed = myBreed bruno
