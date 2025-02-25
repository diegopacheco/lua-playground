function fibonacci(n)
    local fib = {1, 1}
    for i = 3, n do
        fib[i] = fib[i-1] + fib[i-2]
    end
    return fib
end

local sequence = fibonacci(10)
print("Fibonacci sequence (first 10 numbers):")
for i, num in ipairs(sequence) do
    print(i .. ": " .. num)
end