module Definitions (
    -- HERE WE EXPORT THE TYPE AND THE CONSTRUCTOR
    Essays (Essays),
    -- BELOW SHORTHAND FOR EXPORTING THE TYPE AND THE CONSTRUCTOR
    Student (..),
    Level (..)
) where
    data Essays = Essays
        {
            idEssay :: String,
            essaySubject :: String,
            score :: Int,
            numberOfQuestions :: Int
        }
    data Student = Student
        {
            idStudent :: String,
            fristname :: String,
            lastName :: String,
            level :: String,
            age :: Int,
            essays :: [Essays]
        }

    data Level = Level
        {
            idLevel :: String,
            levelName :: String,
            numberOfStudents :: Int,
            students :: [Student]
        }
