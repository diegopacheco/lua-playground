local function serialize(t, indent)
    indent = indent or 0
    local spaces = string.rep("  ", indent)
    if type(t) ~= "table" then
        if type(t) == "string" then return '"' .. t .. '"'
        else return tostring(t) end
    end
    local result = "{\n"
    for k, v in pairs(t) do
        result = result .. spaces .. "  "
        if type(k) == "string" then result = result .. k
        else result = result .. "[" .. k .. "]" end
        result = result .. " = " .. serialize(v, indent + 1) .. ",\n"
    end
    return result .. spaces .. "}"
end

local function deserialize(code)
    local func, err = load("return " .. code)
    if func then return func() else return nil, err end
end

local function deep_clone(t)
    if type(t) ~= "table" then return t end
    local clone = {}
    for k, v in pairs(t) do clone[deep_clone(k)] = deep_clone(v) end
    return clone
end

local function table_to_string(t, depth)
    depth = depth or 0
    if depth > 3 then return "..." end
    if type(t) ~= "table" then
        if type(t) == "string" then return '"' .. t .. '"'
        else return tostring(t) end
    end
    local result, first = "{", true
    for k, v in pairs(t) do
        if not first then result = result .. ", " end
        first = false
        if type(k) == "string" then result = result .. k .. "="
        else result = result .. "[" .. tostring(k) .. "]=" end
        if type(v) == "table" then result = result .. table_to_string(v, depth + 1)
        else result = result .. tostring(v) end
    end
    return result .. "}"
end

print("Serialize:")
local data = {name = "John", age = 30, active = true}
print(serialize(data))

print("\nTable to String:")
local nested = {x = 10, y = 20, nested = {a = 1, b = 2}}
print(table_to_string(nested))

print("\nDeep Clone:")
local original = {a = {b = {c = 1}}, d = 2}
local cloned = deep_clone(original)
cloned.a.b.c = 999
print("Original:", original.a.b.c)
print("Cloned:", cloned.a.b.c)
