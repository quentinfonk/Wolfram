module Main where

import System.Exit
import System.Environment
import Check
import Lib

data Config = Cfg {
rule :: Int,
start :: Int,
line :: Int,
window :: Int,
move :: Int,
precedline :: String,
binary :: String
} deriving Show

endLine :: Config -> Int -> IO()
endLine cfg c | window cfg+1 > 1 = putStr " " >> endLine (cfg {window = window cfg - 1}) (c+1)
              | otherwise = putStr "\n"

ver :: Int -> String -> Int
ver 0 _ = 2
ver 1 _ = 2
ver _ str | myLength str >= 2 = 3
          | otherwise = 2

verif :: Int -> Int -> Config -> Bool
verif d c cfg | c+1 > (myLength (precedline cfg) - d) `div` 2 && c+1 < myLength (precedline cfg) - (myLength (precedline cfg) - d) `div` 2 = True
              | otherwise = False

printLine :: String -> Config -> Int -> Bool -> Int -> Int -> IO()
printLine (x:xs) cfg a b 0 d = printLine xs cfg a b 1 d
printLine (x:xs) cfg a b 1 d = printLine xs cfg a b 2 d
printLine [] cfg _ True c d =  endLine cfg c
printLine b cfg a False _ d | start cfg > 0 = putStr ""
                            | window cfg > a = putStr " " >> printLine (binary cfg) (cfg {window = window cfg - 1}) a False 0 d
                            | otherwise = printLine (precedline cfg) (cfg {window = window cfg - 1}) a True 0 d
printLine (x:xs) cfg a b c d | x == '0' && ver c xs /= 2 && verif d c cfg = putStr " " >> printLine xs cfg a True (c+1) d
                             | x == '1' && ver c xs /= 2 && verif d c cfg = putStr "*" >> printLine xs cfg a True (c+1) d
                             | otherwise = printLine xs cfg a b (c+1) d

check :: Config -> Int -> String
check cfg a | a < 2 || a >= myLength (precedline cfg) = "0"
            | look (myReverse(func (precedline cfg) a "")) (binary cfg) = "1"
            | otherwise = "0"

changeLine :: Config -> String -> Int -> String
changeLine cfg str a | a == myLength (precedline cfg) + 2 = str
                     | otherwise = changeLine cfg (str ++ check cfg a) (a + 1)

algo :: Config -> Bool -> Int -> Int -> IO()
algo cfg a b c | not a = printLine (precedline cfg) cfg (window cfg `div` 2) False 0 c >> algo cfg {window = window cfg -2} True b c
           | b /= 1 = algo (cfg {start = start cfg -1, line = line cfg - 1, precedline = changeLine cfg "" 0}) False (b-1) c
           | otherwise = exitSuccess

checkAll :: Config -> Bool
checkAll cfg | rule cfg < 0 || rule cfg > 255 = False
             | start cfg < 0 = False
             | window cfg < 0 = False
             | line cfg == -111444 || line cfg > 0 = True
             | otherwise = False

checkLigne :: [String] -> Config -> Bool -> Config
checkLigne [] cfg False = cfg {rule = -1}
checkLigne [] cfg True | not (checkAll cfg) = cfg {rule = -1}
                       | otherwise = cfg
checkLigne (x:xs) cfg b | not b && not (checkNbr x False) = cfg {rule = -1}
           | b && checkNbr x False = cfg {rule = -1}
           | checkNbr x False && not b = checkLigne xs cfg True
           | x == "--rule" = checkLigne xs cfg{rule = getNbr xs} False
           | x == "--start" = checkLigne xs cfg{start = getNbr xs} False
           | x == "--lines" = checkLigne xs cfg{line = getNbr xs} False
           | x == "--window" = checkLigne xs cfg{window = getNbr xs} False
           | otherwise = cfg {rule = -1}

checkArgs :: [String] -> Config -> Bool
checkArgs [] _ = True
checkArgs [""] _ = False
checkArgs ("":_) _ = False
checkArgs arg cfg | rule cfg == -1 = False
                  | otherwise = True

isArgs :: [String] -> Bool
isArgs [] = False
isArgs [[]] = False
isArgs _ = True

errorHandleur :: [String] -> Bool
errorHandleur arg | not (isArgs arg) = False
                  | otherwise = True

wolfram :: [String] -> Config -> IO()
wolfram arg cfg | not (checkArgs arg cfg) = putStrLn "KO" >> exitWith(ExitFailure 84)
                 | otherwise = algo cfg {binary = intobin (rule cfg) 0} False (start cfg + line cfg) (window cfg)

main :: IO()
main = do
    let cfg = Cfg {rule = -1, start = 0, line = -111444, window = 80, move = 0, precedline = "00100", binary = ""}
    arg <- getArgs
    if not (errorHandleur arg)
       then putStrLn "No ruleset -- KO" >> exitWith(ExitFailure 84)
    else wolfram arg (checkLigne arg cfg True)
