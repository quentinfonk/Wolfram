module Lib where

getNbr :: [String] -> Int
getNbr [] = 0 -- ERROR
getNbr (x:xs) = read x :: Int

myLength :: String -> Int
myLength [] = 0
myLength (_:xs) = 1 + myLength xs

myAppend :: [a] -> [a] -> [a]
myAppend (x:xs) c = x : myAppend xs c
myAppend [] x = x

myReverse :: [a] -> [a]
myReverse [] = []
myReverse (x:xs) = myAppend (myReverse xs) [x]

bintoint :: Int -> Int -> Int
bintoint a b | a >= 100 = bintoint (a - 100) (b + 4)
             | a >= 10 = bintoint (a - 10) (b + 2)
             | a >= 1 = bintoint (a - 1) (b + 1)
             | otherwise = b

remp :: String -> Int -> String -> String
remp [] _ stock = stock
remp (x:xs) b stock | b-9 == 0 = remp xs b (stock ++ [x])
                    | otherwise = remp (x:xs) (b+1) (stock ++ "0")

intobin :: Int -> Int -> String
intobin a c | a >= 128 = intobin (a - 128) (c + 10000000)
            | a >= 64 = intobin (a - 64) (c + 1000000)
            | a >= 32 = intobin (a - 32) (c + 100000)
            | a >= 16 = intobin (a - 16) (c + 10000)
            | a >= 8 = intobin (a - 8) (c + 1000)
            | a >= 4 = intobin (a - 4) (c + 100)
            | a >= 2 = intobin (a - 2) (c + 10)
            | a >= 1 = intobin (a - 1) (c + 1)
            | otherwise = remp (show c) (myLength (show c)) ""

stri :: Int -> String -> Int -> Bool
stri _ [] _ = False
stri a (x:xs) b | a == b && x == '1' = True
                | a /= b = stri a xs (b+1)
                | otherwise = False

see :: Int -> String -> Bool
see a b | stri a b 0 = True
        | otherwise = False

look :: String -> String -> Bool
look str a | see (8 - bintoint (read str :: Int) 0) a = True
           | otherwise = False

func :: String -> Int -> String -> String
func [] _ _ = ""
func (x:xs) a str | a-3 >= 0 = func xs (a-1) str
                  | a /= 0 = func xs (a-1) str ++ [x]
                  | otherwise = str ++ [x]
