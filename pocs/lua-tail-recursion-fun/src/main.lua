print("=== Non-Tail Recursive Factorial ===")
function factorial(n)
    if n == 0 then
        return 1
    else
        return n * factorial(n - 1)
    end
end

print("Factorial 5:", factorial(5))
print("Factorial 10:", factorial(10))

print("\n=== Tail Recursive Factorial ===")
function factorial_tail(n, acc)
    acc = acc or 1
    if n == 0 then
        return acc
    else
        return factorial_tail(n - 1, n * acc)
    end
end

print("Tail Factorial 5:", factorial_tail(5))
print("Tail Factorial 10:", factorial_tail(10))

print("\n=== Non-Tail Recursive Sum ===")
function sum_list(list, i)
    i = i or 1
    if i > #list then
        return 0
    else
        return list[i] + sum_list(list, i + 1)
    end
end

local numbers = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
print("Sum:", sum_list(numbers))

print("\n=== Tail Recursive Sum ===")
function sum_list_tail(list, i, acc)
    i = i or 1
    acc = acc or 0
    if i > #list then
        return acc
    else
        return sum_list_tail(list, i + 1, acc + list[i])
    end
end

print("Tail Sum:", sum_list_tail(numbers))

print("\n=== Non-Tail Recursive Reverse ===")
function reverse(list, i)
    i = i or 1
    if i > #list then
        return {}
    else
        local rest = reverse(list, i + 1)
        table.insert(rest, list[i])
        return rest
    end
end

local result = reverse({1, 2, 3, 4, 5})
print("Reversed:", table.concat(result, ", "))

print("\n=== Tail Recursive Reverse ===")
function reverse_tail(list, i, acc)
    i = i or 1
    acc = acc or {}
    if i > #list then
        return acc
    else
        table.insert(acc, 1, list[i])
        return reverse_tail(list, i + 1, acc)
    end
end

result = reverse_tail({1, 2, 3, 4, 5})
print("Tail Reversed:", table.concat(result, ", "))

print("\n=== Tail Recursive Fibonacci ===")
function fib_tail(n, a, b)
    a = a or 0
    b = b or 1
    if n == 0 then
        return a
    else
        return fib_tail(n - 1, b, a + b)
    end
end

print("Fibonacci 10:", fib_tail(10))
print("Fibonacci 20:", fib_tail(20))

print("\n=== Tail Recursive GCD ===")
function gcd_tail(a, b)
    if b == 0 then
        return a
    else
        return gcd_tail(b, a % b)
    end
end

print("GCD(48, 18):", gcd_tail(48, 18))
print("GCD(100, 35):", gcd_tail(100, 35))

print("\n=== Tail Recursive Power ===")
function power_tail(base, exp, acc)
    acc = acc or 1
    if exp == 0 then
        return acc
    else
        return power_tail(base, exp - 1, acc * base)
    end
end

print("2^8:", power_tail(2, 8))
print("3^5:", power_tail(3, 5))
