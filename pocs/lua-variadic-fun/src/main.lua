print("=== Basic Variadic Function ===")
function sum(...)
    local total = 0
    for _, v in ipairs({...}) do
        total = total + v
    end
    return total
end

print("Sum of 1,2,3:", sum(1, 2, 3))
print("Sum of 10,20,30,40:", sum(10, 20, 30, 40))

print("\n=== Using select ===")
function print_args(...)
    local n = select("#", ...)
    print("Number of arguments:", n)
    for i = 1, n do
        print("Arg " .. i .. ":", select(i, ...))
    end
end

print_args("apple", "banana", "cherry")

print("\n=== Variadic with Named Parameters ===")
function greet(greeting, ...)
    print(greeting)
    for _, name in ipairs({...}) do
        print("  Hello,", name)
    end
end

greet("Welcome!", "Alice", "Bob", "Charlie")

print("\n=== Forward Arguments ===")
function wrapper(...)
    print("Wrapper called with", select("#", ...), "args")
    return sum(...)
end

print("Result:", wrapper(5, 10, 15, 20))

print("\n=== Filter Nils ===")
function count_non_nil(...)
    local count = 0
    for i = 1, select("#", ...) do
        if select(i, ...) ~= nil then
            count = count + 1
        end
    end
    return count
end

print("Non-nil count:", count_non_nil(1, nil, 3, nil, 5))

print("\n=== Concatenate All ===")
function concat_all(sep, ...)
    local parts = {...}
    local result = ""
    for i, v in ipairs(parts) do
        result = result .. tostring(v)
        if i < #parts then
            result = result .. sep
        end
    end
    return result
end

print("Concatenated:", concat_all("-", "lua", "is", "fun"))

print("\n=== Max of All ===")
function max_all(...)
    local max_val = select(1, ...)
    for i = 2, select("#", ...) do
        local val = select(i, ...)
        if val > max_val then
            max_val = val
        end
    end
    return max_val
end

print("Max:", max_all(3, 7, 2, 9, 1, 5))

print("\n=== Multiple Return Values ===")
function stats(...)
    local vals = {...}
    local sum = 0
    local count = #vals
    local min = vals[1]
    local max = vals[1]

    for _, v in ipairs(vals) do
        sum = sum + v
        if v < min then min = v end
        if v > max then max = v end
    end

    return sum, sum / count, min, max
end

local s, avg, min, max = stats(10, 20, 30, 40, 50)
print("Sum:", s, "Average:", avg, "Min:", min, "Max:", max)

print("\n=== Select Range ===")
function get_range(start, ...)
    local result = {}
    for i = start, select("#", ...) do
        table.insert(result, select(i, ...))
    end
    return table.unpack(result)
end

print("Range from 3rd:", get_range(3, "a", "b", "c", "d", "e"))

print("\n=== Variadic Map ===")
function map(fn, ...)
    local result = {}
    for i = 1, select("#", ...) do
        result[i] = fn(select(i, ...))
    end
    return table.unpack(result)
end

print("Doubled:", map(function(x) return x * 2 end, 1, 2, 3, 4, 5))
