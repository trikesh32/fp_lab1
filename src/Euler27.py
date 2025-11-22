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