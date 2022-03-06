data TurnstileState = Locked | Unlocked deriving (Eq, Show)

data TurnstileOutput = Thank | Open | Tut deriving (Eq, Show)

coin, push :: TurnstileState -> (TurnstileOutput, TurnstileState)
coin _ = (Thank, Unlocked)
push Unlocked = (Open, Locked)
push Locked = (Tut, Locked)


monday :: TurnstileState -> ([TurnstileOutput], TurnstileState)
monday s0 =
    let (a1, s1) = coin s0
        (a2, s2) = push s1
        (a3, s3) = push s2
        (a4, s4) = coin s3
        (a5, s5) = push s4
    in ([a1, a2, a3, a4, a5], s5)
