print("=== Basic Upvalue ===")
function create_counter()
    local count = 0
    return function()
        count = count + 1
        return count
    end
end

local counter = create_counter()
print("Count 1:", counter())
print("Count 2:", counter())
print("Count 3:", counter())

print("\n=== Get Upvalue ===")
local name, value = debug.getupvalue(counter, 1)
print("Upvalue name:", name)
print("Upvalue value:", value)

print("\n=== Set Upvalue ===")
debug.setupvalue(counter, 1, 100)
print("After setting to 100:", counter())
print("Next value:", counter())

print("\n=== Multiple Upvalues ===")
function create_calculator(x, y)
    return function(op)
        if op == "add" then
            return x + y
        elseif op == "sub" then
            return x - y
        elseif op == "mul" then
            return x * y
        end
    end
end

local calc = create_calculator(10, 5)
print("10 + 5 =", calc("add"))

local n1, v1 = debug.getupvalue(calc, 1)
local n2, v2 = debug.getupvalue(calc, 2)
print("Upvalue 1:", n1, "=", v1)
print("Upvalue 2:", n2, "=", v2)

debug.setupvalue(calc, 1, 20)
debug.setupvalue(calc, 2, 3)
print("After modification 20 + 3 =", calc("add"))

print("\n=== Shared Upvalues ===")
function create_accessors()
    local value = 42

    local getter = function()
        return value
    end

    local setter = function(v)
        value = v
    end

    return getter, setter
end

local get, set = create_accessors()
print("Initial value:", get())
set(99)
print("After set:", get())

print("\n=== Upvalue Introspection ===")
function inspect_upvalues(func)
    local i = 1
    while true do
        local name, value = debug.getupvalue(func, i)
        if not name then break end
        print("Upvalue " .. i .. ":", name, "=", value)
        i = i + 1
    end
end

function outer()
    local a = 1
    local b = 2
    local c = 3
    return function()
        return a + b + c
    end
end

local inner = outer()
print("Inspecting inner function:")
inspect_upvalues(inner)

print("\n=== Modify Upvalues ===")
function double_all_upvalues(func)
    local i = 1
    while true do
        local name, value = debug.getupvalue(func, i)
        if not name then break end
        if type(value) == "number" then
            debug.setupvalue(func, i, value * 2)
        end
        i = i + 1
    end
end

print("Before doubling:", inner())
double_all_upvalues(inner)
print("After doubling:", inner())

print("\n=== Closure Factory ===")
function make_multiplier(factor)
    return function(x)
        return x * factor
    end
end

local times2 = make_multiplier(2)
local times5 = make_multiplier(5)

print("3 * 2 =", times2(3))
print("3 * 5 =", times5(3))

local n, v = debug.getupvalue(times2, 1)
print("times2 upvalue:", n, "=", v)
local n, v = debug.getupvalue(times5, 1)
print("times5 upvalue:", n, "=", v)

print("\n=== Upvalue State Machine ===")
function create_state_machine()
    local state = "IDLE"

    return {
        get_state = function()
            return state
        end,
        transition = function(new_state)
            state = new_state
        end
    }
end

local sm = create_state_machine()
print("Initial state:", sm.get_state())
sm.transition("RUNNING")
print("New state:", sm.get_state())

local n, v = debug.getupvalue(sm.get_state, 1)
print("State upvalue:", v)

print("\n=== Upvalue Chain ===")
function outer_func()
    local outer_val = "outer"

    function middle_func()
        local middle_val = "middle"

        function inner_func()
            return outer_val .. "-" .. middle_val
        end

        return inner_func
    end

    return middle_func()
end

local chained = outer_func()
print("Chained result:", chained())
print("Upvalues of chained:")
inspect_upvalues(chained)
