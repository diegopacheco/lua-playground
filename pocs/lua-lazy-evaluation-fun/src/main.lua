local function lazy(computation)
    local cached, value = false, nil
    return function()
        if not cached then value = computation(); cached = true end
        return value
    end
end

local function infinite_range(start, step)
    step = step or 1
    local current = start - step
    return function() current = current + step; return current end
end

local function lazy_map(func, iterator)
    return function()
        local value = iterator()
        if value then return func(value) end
        return nil
    end
end

local function lazy_filter(predicate, iterator)
    return function()
        while true do
            local value = iterator()
            if value == nil then return nil end
            if predicate(value) then return value end
        end
    end
end

local function lazy_table(compute)
    local cache = {}
    return setmetatable({}, {
        __index = function(t, k)
            if cache[k] == nil then cache[k] = compute(k) end
            return cache[k]
        end
    })
end

print("Lazy value:")
local expensive = lazy(function() print("Computing..."); return 42 end)
print("Value:", expensive())
print("Cached:", expensive())

print("\nInfinite range:")
local nums = infinite_range(1, 1)
for i = 1, 5 do print("  ", nums()) end

print("\nLazy map:")
local squares = lazy_map(function(x) return x * x end, infinite_range(1, 1))
for i = 1, 5 do print("  ", squares()) end

print("\nLazy table:")
local powers = lazy_table(function(n) return n * n end)
print("powers[5]:", powers[5])
print("powers[10]:", powers[10])
