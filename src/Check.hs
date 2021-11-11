module Check where
import Data.Char

checkNbr :: String -> Bool -> Bool
checkNbr z _ | z == "-" = False
checkNbr [] _ = True
checkNbr (x:xs) False | x == '-' = checkNbr xs True
checkNbr x _ | all isDigit x = True
             | otherwise = False
