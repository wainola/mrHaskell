import Data.Monoid

-- MONOIDS AND SEMIGROUPS
-- DEFINED BINARY OPERATION THAT ENFORCE LAW OF IDENTITY
x1 = mappend [1..2] [3..4]
x2 = mappend [] [1..3]
x3 = mappend mempty [1..4]
x4 = getSum $ Sum 5 <> Sum 4
x5 = (\(Just x) -> x) $ getFirst $ First (Just 5) <> First (Just 4)
x6 = getLast $ Last (Just 2) <> Last (Just 3)
noFirst = First Nothing `mappend` First Nothing

-- REUSING ALGEBRAS
data Booly' a = False' | True' deriving (Eq, Show)

instance Semigroup (Booly' a) where
    (<>) False' _ = False'
    (<>) _ False' = False'
    (<>) True' True' = True'

instance Monoid (Booly' a) where
    mempty = True'

data Optional a = Nada | Only a deriving (Eq, Show)

instance Semigroup (Optional a) where
    (<>) Nada _ = Nada
    (<>) _ Nada = Nada
    -- (<>) (Only b) (Only b')= Only $ mappend b b'


newtype Listy a = Listy [a] deriving (Eq, Show)

instance Semigroup (Listy a) where
    (<>) (Listy l) (Listy l') = Listy $ mappend l l'
