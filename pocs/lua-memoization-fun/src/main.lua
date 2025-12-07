local function memoize(func)
    local cache = {}
    return function(arg)
        if cache[arg] == nil then cache[arg] = func(arg) end
        return cache[arg]
    end
end

local function memoize_with_stats(func)
    local cache, hits, misses = {}, 0, 0
    local memoized = function(arg)
        if cache[arg] ~= nil then hits = hits + 1; return cache[arg]
        else misses = misses + 1; cache[arg] = func(arg); return cache[arg] end
    end
    local stats = function() return {hits = hits, misses = misses, total = hits + misses} end
    return memoized, stats
end

local function lru_cache(max_size)
    local cache, order = {}, {}
    local function get(key)
        if cache[key] then
            for i, k in ipairs(order) do if k == key then table.remove(order, i); break end end
            table.insert(order, key)
        end
        return cache[key]
    end
    local function set(key, value)
        if not cache[key] then
            if #order >= max_size then cache[table.remove(order, 1)] = nil end
        else
            for i, k in ipairs(order) do if k == key then table.remove(order, i); break end end
        end
        cache[key] = value; table.insert(order, key)
    end
    return {get = get, set = set}
end

print("Basic Memoization:")
local fib_cache = {}
local function fib(n)
    if n <= 1 then return n end
    if fib_cache[n] then return fib_cache[n] end
    fib_cache[n] = fib(n - 1) + fib(n - 2)
    return fib_cache[n]
end
print("Fib(10):", fib(10))
print("Fib(20):", fib(20))

print("\nWith Stats:")
local calc, stats = memoize_with_stats(function(n) return n * n end)
calc(5); calc(5); calc(10); calc(5)
local s = stats()
print("Hits:", s.hits, "Misses:", s.misses)
