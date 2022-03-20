module MRh6 where

    import Utils (emptyString, checkFirstName, checkLastname, checkLevel, checkAge, addEssay, Essays)

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


    data Student = Student {
        idStudent :: String,
        fristname :: String,
        lastName :: String,
        level :: String,
        age :: Int,
        essays :: [Essays]
    }

    data Level = Level {
        idLevel :: String,
        levelName :: String,
        numberOfStudents :: Int,
        students :: [Student]
    }

    class Essay n where
        getEssayId :: n -> String
        getEssaySubject :: n -> String
        updateEssaySubject :: n -> String -> Essays
        updateScore :: n -> Int -> Essays
        updateNumberOfQuestions :: n -> Int -> Essays

    instance Essay Essays where
        getEssayId (Essays i _ _ _ ) = "The id is: " <> i
        getEssaySubject (Essays _ e _ _ ) = "The subject is: " <> e
        updateEssaySubject (Essays idEs _ score numQues) newEssaySubject = Essays idEs newEssaySubject score numQues
        updateScore (Essays idEs essSub _ numQues) newScore = Essays idEs essSub newScore numQues
        updateNumberOfQuestions (Essays idEs essSub score _) newNumQuestion = Essays idEs essSub score newNumQuestion

    class SingleStudent n where
        updateName :: n -> String -> String -> Student
        updateLevel :: n -> String -> Student
        updateAge :: n -> Int -> Student
        updateEssays :: n -> Essays -> Student

    instance SingleStudent Student where
        updateName (Student idS firstS lastS levelS ageS essaysS) firstnewname lastnewname = case (checkFirstName firstnewname, checkLastname lastnewname) of
            (Left s, Left ss) -> Student idS firstS lastS levelS ageS essaysS
            (Left s, Right ss) -> Student idS firstS ss levelS ageS essaysS
            (Right s, Left ss) -> Student idS s lastS levelS ageS essaysS
            (Right s, Right ss) -> Student idS s ss levelS ageS essaysS
        updateLevel (Student idS firstS lastS levelS ageS essaysS) newLevel = case checkLevel newLevel of
            Right s -> Student idS firstS lastS s ageS essaysS
            _ -> Student idS firstS lastS levelS ageS essaysS
        updateAge (Student idS firstS lastS levelS ageS essaysS) newAge = case checkAge newAge of
            Right a -> Student idS firstS lastS levelS a essaysS
            _ -> Student idS firstS lastS levelS ageS essaysS
        updateEssays (Student idS firstS lastS levelS ageS essaysS) newEssayToAppend =
            let newEssays = addEssay newEssayToAppend essaysS
                newStudent = Student idS firstS lastS levelS ageS newEssays
            in newStudent



    func :: Int -> String -> String -> (Int, String, String)
    func i s ss
        | i == 0 && s == "" && ss == "" = (0, "empty", "empty")
        | i /= 0 && s == "" && ss == "" = (i, "empty", "empty")
        | i /= 0 && s /= "" && ss == "" = (i, s, "empty")
        | i /= 0 && s == "" && ss /= "" = (i, "empty", ss)
        | otherwise = (i, s, ss)


    func' :: Maybe Int -> Maybe String -> Maybe (Int, String)
    func' Nothing Nothing = Nothing
    func' Nothing (Just s) = Just (0, s)
    func' (Just i) Nothing = Just (i, "no value")
    func' (Just i) (Just s) = Just (i, s)

    func'' :: Maybe Int -> Maybe String -> Maybe String -> Maybe (Int, String, String)
    func'' Nothing Nothing Nothing = Nothing
    func'' Nothing (Just s) (Just ss) = Just (0, s, ss)
    func'' Nothing  Nothing (Just ss) = Just (0, "no value", ss)
    func'' (Just i) Nothing (Just ss) = Just (i, "no value", ss)
    func'' (Just i) (Just s) Nothing = Just (i, s, "no value")
    func'' (Just i) (Just s) (Just ss) = Just (i, s, ss)
    func'' (Just i) Nothing Nothing = Just (i, "no value", "no value")
    func'' Nothing (Just s) Nothing = Just (0, s, "no value")
