module Euler4 where

import Data.List (foldl')
minNum :: Int
minNum = 100
maxNum :: Int
maxNum = 999

isPalindrome :: Int -> Bool
isPalindrome x = show x == reverse (show x)

largestPalindromeTailRec :: Int
largestPalindromeTailRec = go maxNum 0
  where
    go i best
        | i < minNum = best
        | otherwise = go (i - 1) $ findPalindrome i maxNum best

    findPalindrome i j currentBest
        | j < i = currentBest
        | j < minNum = currentBest
        | product > currentBest && isPalindrome product = findPalindrome i (j - 1) product
        | otherwise = findPalindrome i (j - 1) currentBest
      where
        product = i * j
largestPalindromeRec :: Int
largestPalindromeRec = search maxNum maxNum
  where
    search i j
        | i < minNum = 0
        | j < minNum = search (i - 1) maxNum
        | isPalindrome product = max product (search i (j - 1))
        | otherwise = search i (j - 1)
      where
        product = i * j
largestPalindromeModular :: Int
largestPalindromeModular =
    let
        allProducts = [i * j | i <- [minNum .. maxNum], j <- [i .. maxNum]]
        palindromes = filter isPalindrome allProducts
     in
        foldl' max 0 palindromes
largestPalindromeMap :: Int
largestPalindromeMap =
    maximum $ map processRow [minNum .. maxNum]
  where
    processRow i =
        maximum $
            (0 :) $
                map (i *) $
                    filter (\j -> isPalindrome (i * j)) [i .. maxNum]
largestPalindromeList :: Int
largestPalindromeList = maximum [r | i <- [minNum .. maxNum], j <- [i .. maxNum], let r = i * j, isPalindrome r]
