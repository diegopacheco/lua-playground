print("=== Weak Keys ===")
local weak_keys = {}
setmetatable(weak_keys, {__mode = "k"})

local key1 = {name = "first"}
local key2 = {name = "second"}
weak_keys[key1] = "value1"
weak_keys[key2] = "value2"

print("Before GC:", weak_keys[key1], weak_keys[key2])
key1 = nil
collectgarbage()
print("After GC key1:", weak_keys[key1])

print("\n=== Weak Values ===")
local weak_values = {}
setmetatable(weak_values, {__mode = "v"})

weak_values.a = {data = "important"}
weak_values.b = {data = "temporary"}
local ref = weak_values.a

print("Before GC:", weak_values.a, weak_values.b)
collectgarbage()
print("After GC (a has ref):", weak_values.a, weak_values.b)

print("\n=== Weak Keys and Values ===")
local weak_both = {}
setmetatable(weak_both, {__mode = "kv"})

local k = {id = 1}
local v = {content = "data"}
weak_both[k] = v

print("Before GC:", weak_both[k])
k = nil
v = nil
collectgarbage()
print("After GC:", next(weak_both))

print("\n=== Memoization Cache ===")
local cache = {}
setmetatable(cache, {__mode = "v"})

function expensive_compute(n)
    if cache[n] then
        print("Cache hit for", n)
        return cache[n]
    end
    print("Computing for", n)
    local result = {value = n * n}
    cache[n] = result
    return result
end

local r1 = expensive_compute(5)
local r2 = expensive_compute(5)
print("Results equal:", r1 == r2)

print("\n=== Object Registry ===")
local objects = {}
setmetatable(objects, {__mode = "v"})

local id = 0
function create_object(data)
    id = id + 1
    local obj = {id = id, data = data}
    objects[id] = obj
    return obj
end

local obj1 = create_object("first")
local obj2 = create_object("second")
print("Registry size:", #objects)
obj1 = nil
collectgarbage()
print("After GC, object 1:", objects[1])
print("Object 2 still exists:", objects[2] ~= nil)
