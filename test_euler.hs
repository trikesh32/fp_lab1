{-# LANGUAGE BangPatterns #-}

module Main where

import Euler4
import Euler27

testEuler4 :: IO ()
testEuler4 = do
    putStrLn "Testing Euler4 implementations..."
    
    let expected = 906609
    let results = [ largestPalindromeTailRec
                  , largestPalindromeRec
                  , largestPalindromeModular
                  , largestPalindromeMap
                  , largestPalindromeList
                  ]
    
    let allCorrect = all (== expected) results
    
    if allCorrect
        then putStrLn $ "✓ All Euler4 implementations return " ++ show expected
        else do
            putStrLn "✗ Euler4 implementations disagree:"
            mapM_ (\(name, result) -> putStrLn $ "  " ++ name ++ ": " ++ show result) 
                [ ("TailRec", largestPalindromeTailRec)
                , ("Rec", largestPalindromeRec)
                , ("Modular", largestPalindromeModular)
                , ("Map", largestPalindromeMap)
                , ("List", largestPalindromeList)
                ]

testEuler27 :: IO ()
testEuler27 = do
    putStrLn "Testing Euler27 implementations..."
    
    let expected = -59231
    let results = [ solutionTailRec
                  , solutionRec
                  , solutionModular
                  , solutionMap
                  , solutionList
                  ]
    
    let allCorrect = all (== expected) results
    
    if allCorrect
        then putStrLn $ "✓ All Euler27 implementations return " ++ show expected
        else do
            putStrLn "✗ Euler27 implementations disagree:"
            mapM_ (\(name, result) -> putStrLn $ "  " ++ name ++ ": " ++ show result) 
                [ ("TailRec", solutionTailRec)
                , ("Rec", solutionRec)
                , ("Modular", solutionModular)
                , ("Map", solutionMap)
                , ("List", solutionList)
                ]

main :: IO ()
main = do
    testEuler4
    putStrLn ""
    testEuler27