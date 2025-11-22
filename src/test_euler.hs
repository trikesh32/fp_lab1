module Main where

import Euler27
import Euler4
import System.Exit (exitFailure, exitSuccess)

testEuler4 :: IO Bool
testEuler4 = do
    putStrLn "Testing Euler4 implementations..."

    let expected = 906609
    let results =
            [ largestPalindromeTailRec
            , largestPalindromeRec
            , largestPalindromeModular
            , largestPalindromeMap
            , largestPalindromeList
            ]

    let allCorrect = all (== expected) results

    if allCorrect
        then putStrLn ("All Euler4 implementations return " ++ show expected) >> return True
        else do
            putStrLn "Euler4 implementations disagree:"
            mapM_
                (\(name, result) -> putStrLn $ "  " ++ name ++ ": " ++ show result)
                [ ("TailRec", largestPalindromeTailRec)
                , ("Rec", largestPalindromeRec)
                , ("Modular", largestPalindromeModular)
                , ("Map", largestPalindromeMap)
                , ("List", largestPalindromeList)
                ]
            return False

testEuler27 :: IO Bool
testEuler27 = do
    putStrLn "Testing Euler27 implementations..."

    let expected = -59231
    let results =
            [ solutionTailRec
            , solutionRec
            , solutionModular
            , solutionMap
            , solutionList
            ]

    let allCorrect = all (== expected) results

    if allCorrect
        then putStrLn ("All Euler27 implementations return " ++ show expected) >> return True
        else do
            putStrLn "Euler27 implementations disagree:"
            mapM_
                (\(name, result) -> putStrLn $ "  " ++ name ++ ": " ++ show result)
                [ ("TailRec", solutionTailRec)
                , ("Rec", solutionRec)
                , ("Modular", solutionModular)
                , ("Map", solutionMap)
                , ("List", solutionList)
                ]
            return False

main :: IO ()
main = do
    success1 <- testEuler4
    putStrLn ""
    success2 <- testEuler27

    if success1 && success2
        then putStrLn "All tests passed!" >> exitSuccess
        else putStrLn "Some tests failed!" >> exitFailure