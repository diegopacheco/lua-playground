print("=== Debug Info ===")
function example_function(a, b)
    local info = debug.getinfo(1, "nSl")
    print("Function name:", info.name)
    print("Source:", info.source)
    print("Line defined:", info.linedefined)
    print("Current line:", info.currentline)
    print("What:", info.what)
    return a + b
end

example_function(10, 20)

print("\n=== Stack Trace ===")
function level3()
    for level = 1, 5 do
        local info = debug.getinfo(level, "nSl")
        if not info then break end
        print("Level " .. level .. ":", info.name or "main", "at line", info.currentline or "?")
    end
end

function level2()
    level3()
end

function level1()
    level2()
end

level1()

print("\n=== Local Variables ===")
function show_locals()
    local x = 100
    local y = 200
    local z = "test"

    local i = 1
    while true do
        local name, value = debug.getlocal(1, i)
        if not name then break end
        print("Local " .. i .. ":", name, "=", value)
        i = i + 1
    end
end

show_locals()

print("\n=== Set Local Variable ===")
function modify_local()
    local counter = 0
    print("Before:", counter)
    debug.setlocal(1, 1, 42)
    print("After:", counter)
end

modify_local()

print("\n=== Function Hook ===")
local call_count = 0

function hook_function(event, line)
    if event == "call" then
        call_count = call_count + 1
        local info = debug.getinfo(2, "n")
        if info.name then
            print("Calling:", info.name)
        end
    end
end

debug.sethook(hook_function, "c")

function foo()
    return "foo"
end

function bar()
    return "bar"
end

foo()
bar()
foo()

debug.sethook()
print("Total function calls:", call_count)

print("\n=== Line Hook ===")
local lines = {}

function line_hook(event, line)
    if event == "line" then
        table.insert(lines, line)
    end
end

function traced_function()
    local a = 1
    local b = 2
    local c = a + b
    return c
end

debug.sethook(line_hook, "l")
traced_function()
debug.sethook()

print("Lines executed:", table.concat(lines, ", "))

print("\n=== Traceback ===")
function cause_error()
    error("Intentional error")
end

function caller()
    cause_error()
end

local status, err = pcall(caller)
if not status then
    print("Error occurred:")
    print(debug.traceback(err, 2))
end

print("\n=== Get Registry ===")
local registry = debug.getregistry()
print("Registry type:", type(registry))
print("Registry has _LOADED:", registry._LOADED ~= nil)

print("\n=== Get Metatable ===")
local t = {1, 2, 3}
local mt = {__index = function() return "default" end}
setmetatable(t, mt)

local retrieved_mt = debug.getmetatable(t)
print("Metatable retrieved:", retrieved_mt == mt)

print("\n=== Set Metatable on Non-Tables ===")
local str = "test"
local str_mt = {}
debug.setmetatable(str, str_mt)
print("String metatable set:", debug.getmetatable(str) == str_mt)
