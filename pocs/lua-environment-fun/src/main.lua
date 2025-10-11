print("=== Default Environment ===")
print("_ENV table:", _ENV)
print("Global 'print' in _ENV:", _ENV.print)

x = 10
print("x via _ENV:", _ENV.x)

print("\n=== Custom Environment ===")
local custom_env = {
    print = print,
    message = "Hello from custom env"
}

local f = load("print(message)", nil, "t", custom_env)
f()

print("\n=== Sandboxed Environment ===")
local sandbox = {
    print = print,
    math = math,
    string = string,
    table = table
}

local safe_code = [[
    print("Running in sandbox")
    print("Math sqrt:", math.sqrt(16))
    print("String upper:", string.upper("test"))
]]

local sandboxed = load(safe_code, nil, "t", sandbox)
sandboxed()

print("\n=== Environment Isolation ===")
local env1 = {print = print, name = "env1", value = 100}
local env2 = {print = print, name = "env2", value = 200}

local code = "print(name .. ' has value: ' .. value)"
load(code, nil, "t", env1)()
load(code, nil, "t", env2)()

print("\n=== Environment Manipulation ===")
do
    local _ENV = {
        print = print,
        x = 5,
        y = 10
    }
    print("x + y =", x + y)
end

print("\n=== Restricted Environment ===")
local restricted = {}
setmetatable(restricted, {
    __index = function(t, k)
        if k == "print" or k == "tostring" then
            return _G[k]
        end
        error("Access denied to " .. k)
    end
})

local restricted_code = [[
    print("Can use print")
    print(tostring(123))
]]

load(restricted_code, nil, "t", restricted)()

print("\n=== Environment Chain ===")
local base_env = {print = print, base_value = "from base"}
local derived_env = {derived_value = "from derived"}
setmetatable(derived_env, {__index = base_env})

local chained_code = [[
    print(base_value)
    print(derived_value)
]]

load(chained_code, nil, "t", derived_env)()

print("\n=== Dynamic Environment ===")
local counter = 0
local dynamic_env = setmetatable({}, {
    __index = function(t, k)
        if k == "print" then return print end
        if k == "get_count" then
            counter = counter + 1
            return counter
        end
    end
})

load("print('Count:', get_count)", nil, "t", dynamic_env)()
load("print('Count:', get_count)", nil, "t", dynamic_env)()
load("print('Count:', get_count)", nil, "t", dynamic_env)()
