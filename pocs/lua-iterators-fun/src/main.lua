function stateless_iter(t, i)
    i = i + 1
    local v = t[i]
    if v then
        return i, v
    end
end

function values(t)
    return stateless_iter, t, 0
end

print("=== Stateless Iterator ===")
local nums = {10, 20, 30, 40, 50}
for i, v in values(nums) do
    print(i, v)
end

function stateful_iterator(t)
    local i = 0
    local n = #t
    return function()
        i = i + 1
        if i <= n then
            return t[i]
        end
    end
end

print("\n=== Stateful Iterator ===")
for v in stateful_iterator(nums) do
    print(v)
end

function reverse_iter(t)
    local i = #t + 1
    return function()
        i = i - 1
        if i > 0 then
            return t[i]
        end
    end
end

print("\n=== Reverse Iterator ===")
for v in reverse_iter(nums) do
    print(v)
end

function range(from, to, step)
    step = step or 1
    local current = from - step
    return function()
        current = current + step
        if step > 0 and current <= to or step < 0 and current >= to then
            return current
        end
    end
end

print("\n=== Range Iterator ===")
for i in range(1, 10, 2) do
    print(i)
end

function filter(predicate, iterator, state, var)
    return function(s, v)
        local val
        repeat
            v, val = iterator(s, v)
        until val == nil or predicate(val)
        return v, val
    end, state, var
end

print("\n=== Filter Iterator ===")
for i, v in filter(function(x) return x > 25 end, values(nums)) do
    print(i, v)
end
