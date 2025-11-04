maxPalindrome = 0
for i in range(100, 1000):
    for j in range(i, 1000):
        if str(i * j) == str(i * j)[::-1]:
            maxPalindrome = max(maxPalindrome, i * j)
print(maxPalindrome)