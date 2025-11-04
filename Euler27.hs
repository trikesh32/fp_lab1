module Euler27 where
import Data.List
import Data.Function
isPrime :: Int -> Bool
isPrime n
    | n < 2 = False
    | null [d | d <- [2..floor (sqrt (fromIntegral n)) + 1], n `mod` d == 0] = True
    | otherwise = False

aRange :: [Int]
aRange = [-999..999]

bRange :: [Int]
bRange = filter isPrime [1..1000]
---------------------------------------------------------------------

primeSequenceLengthTailRec :: Int -> Int -> Int
primeSequenceLengthTailRec a b = go 0 0
  where
    go n count
      | isPrime (n*n + a*n + b) = go (n + 1) (count + 1)
      | otherwise = count

findBestTailRec :: ((Int, Int), Int)
findBestTailRec = go aRange bRange ((-1, -1), 0)
  where
    go [] _ best = best
    go (a:as) bs best = case goBs a bs best of
        newBest -> go as bs newBest
    
    goBs a [] best = best
    goBs a (b:bs) best@((_, _), bestLen)
      | len > bestLen = goBs a bs ((a, b), len)
      | otherwise = goBs a bs best
      where len = primeSequenceLengthTailRec a b

solutionTailRec :: Int
solutionTailRec = let ((a, b), _) = findBestTailRec in a * b

---------------------------------------------------------------------

primeSequenceLengthRec :: Int -> Int -> Int
primeSequenceLengthRec a b = countPrimes 0
  where
    countPrimes n
      | isPrime (n*n + a*n + b) = 1 + countPrimes (n + 1)
      | otherwise = 0

findBestRec :: [Int] -> [Int] -> ((Int, Int), Int)
findBestRec [] _ = ((-1, -1), 0)
findBestRec (a:as) bs = 
    let bestInAs = findBestRec as bs
        bestForA = findBestForA a bs ((-1, -1), 0)
    in maxTuple bestInAs bestForA
  where
    findBestForA _ [] best = best
    findBestForA a (b:bs) best =
        let len = primeSequenceLengthRec a b
            current = ((a, b), len)
            newBest = maxTuple best current
        in findBestForA a bs newBest
    
    maxTuple t1@(_, len1) t2@(_, len2)
      | len1 >= len2 = t1
      | otherwise = t2

solutionRec :: Int
solutionRec = let ((a, b), _) = findBestRec aRange bRange in a * b
---------------------------------------------------------------------

solutionModular :: Int
solutionModular = 
    let
        allPairs = [(a, b) | a <- aRange, b <- bRange]
        pairsWithLength = map (\(a, b) -> (a, b, primeSequenceLengthTailRec a b)) allPairs
        validPairs = filter (\(_, _, len) -> len > 0) pairsWithLength
        bestPair = foldl findMax (-1, -1, 0) validPairs
    in case bestPair of
        (a, b, _) -> a * b
  where
    findMax best@(_, _, bestLen) current@(_, _, currentLen)
      | currentLen > bestLen = current
      | otherwise = best
---------------------------------------------------------------------

solutionMap :: Int
solutionMap = 
    let
        mappedPairs = map processPair [(a, b) | a <- aRange, b <- bRange]
        (a, b, _) = maximumBy (compare `on` (\(_, _, len) -> len)) mappedPairs
    in a * b
  where
    processPair (a, b) = (a, b, countSequence a b 0)
    
    countSequence a b n
      | isPrime (n*n + a*n + b) = countSequence a b (n + 1)
      | otherwise = n

---------------------------------------------------------------------

solutionList :: Int
solutionList = 
    let (a, b, _) = maximumBy (compare `on` (\(_, _, len) -> len)) 
            [(a, b, length $ takeWhile (\n -> let x = n*n + a*n + b in x > 0 && isPrime x) [0..]) 
            | a <- aRange, b <- bRange]
    in a * b