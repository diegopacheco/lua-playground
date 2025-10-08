print("=== Load String as Code ===")
local code = "return 10 + 20"
local func = load(code)
local result = func()
print("Result:", result)

print("\n=== Load with Environment ===")
local env = {x = 5, y = 10}
local code_with_env = "return x * y"
local func_env = load(code_with_env, nil, "t", env)
print("Result with env:", func_env())

print("\n=== Load Multiple Statements ===")
local multi = [[
    local a = 10
    local b = 20
    return a + b, a * b
]]
local multi_func = load(multi)
local sum, prod = multi_func()
print("Sum:", sum, "Product:", prod)

print("\n=== Loadfile Simulation ===")
local function load_from_string(str, name)
    return load(str, name, "t")
end

local script = [[
    local function greet(name)
        return "Hello, " .. name
    end
    return greet("Lua")
]]

local loaded = load_from_string(script, "greeting_script")
print("Loaded result:", loaded())

print("\n=== Dynamic Function Creation ===")
local function create_adder(n)
    local code = "return function(x) return x + " .. n .. " end"
    return load(code)()
end

local add5 = create_adder(5)
local add10 = create_adder(10)
print("add5(3):", add5(3))
print("add10(3):", add10(3))

print("\n=== Code Compilation ===")
local source = "return 2 ^ 10"
local compiled = load(source)
print("Type of compiled:", type(compiled))
print("Result:", compiled())

print("\n=== Error Handling in Load ===")
local bad_code = "return 10 +"
local func_or_err, err_msg = load(bad_code)
if not func_or_err then
    print("Compilation error:", err_msg)
end

print("\n=== Runtime Error Handling ===")
local runtime_error = "return unknown_var"
local func_runtime = load(runtime_error)
local success, result = pcall(func_runtime)
if not success then
    print("Runtime error:", result)
end

print("\n=== Load with Chunk Name ===")
local named_chunk = load("return 42", "my_custom_chunk")
local info = debug.getinfo(named_chunk, "S")
print("Chunk name:", info.source)

print("\n=== Binary Chunk Dump ===")
local original = function(x) return x * 2 end
local dumped = string.dump(original)
print("Bytecode length:", #dumped)
print("First bytes:", string.byte(dumped, 1), string.byte(dumped, 2))

local restored = load(dumped)
print("Restored function result:", restored(21))

print("\n=== Loadstring Compatibility ===")
local loadstring = loadstring or load
local compat_func = loadstring("return 'loaded'")
print("Loadstring result:", compat_func())

print("\n=== Multiple Returns from Load ===")
local multi_return = [[
    return 1, 2, 3, 4, 5
]]
local mr_func = load(multi_return)
local a, b, c, d, e = mr_func()
print("Multiple returns:", a, b, c, d, e)

print("\n=== Dynamic Table Creation ===")
local function create_table_code(fields)
    local code = "return {"
    for k, v in pairs(fields) do
        code = code .. k .. "=" .. v .. ","
    end
    code = code .. "}"
    return load(code)()
end

local t = create_table_code({x=10, y=20, z=30})
print("Dynamic table x:", t.x, "y:", t.y, "z:", t.z)

print("\n=== Code Generator ===")
local function generate_fibonacci()
    local code = [[
        local function fib(n)
            if n <= 1 then return n end
            return fib(n-1) + fib(n-2)
        end
        return fib
    ]]
    return load(code)()
end

local fib = generate_fibonacci()
print("Fibonacci 10:", fib(10))
