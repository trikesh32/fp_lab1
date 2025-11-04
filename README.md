# Лабораторная работа №1

**Студент:** Трикашный Михаил Дмитриевич
**Группа:** P3306
**Вариант:** [Задача 4](https://projecteuler.net/problem=4), [Задача 27](https://projecteuler.net/problem=27)

---

## Проблема №4

- **Название**: Largest Palindrome Product

- **Описание**: A palindromic number reads the same both ways. The largest palindrome made from the product of two 2\-digits number is 99 \* 91 = 9009.

- **Задание**: Find the largest palindrome made from the product of two 3\-digit numbers.

### Вспомогательные функции
```haskell
minNum :: Int
minNum = 100
maxNum :: Int
maxNum = 999

isPalindrome :: Int -> Bool
isPalindrome x = show x == reverse (show x)
```

### Монолитная реализация с использованием хвостовой рекурсии

```haskell
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
      where product = i * j
```

### Простое рекурсивное решение

```haskell
largestPalindromeRec :: Int
largestPalindromeRec = search maxNum maxNum
  where
    search i j
      | i < minNum = 0
      | j < minNum = search (i - 1) maxNum
      | isPalindrome product = max product (search i (j - 1))
      | otherwise = search i (j - 1)
      where product = i * j
```

### Модульная реализация

```haskell
largestPalindromeModular :: Int
largestPalindromeModular = 
  let
      allProducts = [i * j | i <- [minNum..maxNum], j <- [i..maxNum]]
      palindromes = filter isPalindrome allProducts
  in foldl' max 0 palindromes
```

### Генерация последовательности через `map`

```haskell
largestPalindromeMap :: Int
largestPalindromeMap = 
  maximum $ map processRow [minNum..maxNum]
  where
    processRow i = maximum $ 
      (0 :) $ map (i *) $ 
      filter (\j -> isPalindrome (i * j)) [i..maxNum]
```

### Работа с списками

```
largestPalindromeList :: Int
largestPalindromeList = maximum [r | i <- [minNum..maxNum], j <- [i..maxNum], let r = i * j, isPalindrome r]
```

### Решение на Python

```python
maxPalindrome = 0
for i in range(100, 1000):
    for j in range(i, 1000):
        if str(i * j) == str(i * j)[::-1]:
            maxPalindrome = max(maxPalindrome, i * j)
print(maxPalindrome)
```

---




## Проблема №27

- **Название**: Quadratic Primes

- **Описание**: Эйлер открыл замечательную квадратичную формулу: $n^2 + n + 41$. Оказалось, что эта формула генерирует 40 простых чисел для $n = 0$ до $39$.

- **Задание**: Найдите произведение коэффициентов $a$ и $b$ для квадратичного выражения $n^2 + an + b$, где $|a| < 1000$ и $|b| \leq 1000$, которое генерирует максимальное количество простых чисел для последовательных значений $n$, начиная с $n = 0$.

### Вспомогательные функции
```haskell
isPrime :: Int -> Bool
isPrime n
    | n < 2 = False
    | null [d | d <- [2..floor (sqrt (fromIntegral n)) + 1], n `mod` d == 0] = True
    | otherwise = False

aRange :: [Int]
aRange = [-999..999]

bRange :: [Int]
bRange = filter isPrime [1..1000]
```

### Монолитная реализация с использованием хвостовой рекурсии

```haskell
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
```

### Простое рекурсивное решение

```haskell
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
```

### Модульная реализация

```haskell
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
```

### Генерация последовательности через `map`

```haskell
solutionMap :: Int
solutionMap = 
    let
        allPairs = [(a, b) | a <- aRange, b <- bRange]
        mappedPairs = map processPair allPairs
        (a, b, _) = maximumBy (compare `on` (\(_, _, len) -> len)) mappedPairs
    in a * b
  where
    processPair (a, b) = (a, b, countSequence a b 0)
    
    countSequence a b n
      | isPrime (n*n + a*n + b) = countSequence a b (n + 1)
      | otherwise = n
```

### Работа со списками

```haskell
solutionList :: Int
solutionList = 
    let (a, b, _) = maximumBy (compare `on` (\(_, _, len) -> len)) 
            [(a, b, length $ takeWhile (\n -> let x = n*n + a*n + b in x > 0 && isPrime x) [0..]) 
            | a <- aRange, b <- bRange]
    in a * b
```
### Решение на Python

```python
def is_prime(n):
    if n < 2:
        return False
    if n == 2:
        return True
    if n % 2 == 0:
        return False
    for i in range(3, int(n**0.5) + 1, 2):
        if n % i == 0:
            return False
    return True

def find_best_quadratic():
    max_length = 0
    best_a = 0
    best_b = 0

    for a in range(-999, 1000):
        for b in range(-1000, 1001):
            n = 0
            while True:
                value = n*n + a*n + b
                if value > 0 and is_prime(value):
                    n += 1
                else:
                    break
            if n > max_length:
                max_length = n
                best_a = a
                best_b = b

    return best_a * best_b

result = find_best_quadratic()
print(result)
```

---

## Выводы

В ходе выполнения лабораторной работы были изучены различные подходы к решению задач в функциональной парадигме на языке Haskell:
- Хвостовая рекурсия показала свою эффективность для итеративных вычислений

- Модульная композиция функций высшего порядка продемонстрировала элегантность и читаемость кода

- List comprehensions предоставили компактный синтаксис для работы с последовательностями

Наиболее идиоматичными для Haskell оказались решения с использованием модульного подхода и list comprehensions, которые сочетают в себе читаемость и эффективность.
