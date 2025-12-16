print("Type Checking:")
print("type(42):", type(42))
print("type('hello'):", type("hello"))
print("type(true):", type(true))
print("type({}):", type({}))

print("\ntonumber:")
print("tonumber('123'):", tonumber("123"))
print("tonumber('3.14'):", tonumber("3.14"))
print("tonumber('invalid'):", tonumber("invalid"))
print("tonumber('FF', 16):", tonumber("FF", 16))
print("tonumber('1010', 2):", tonumber("1010", 2))

print("\ntostring:")
print("tostring(42):", tostring(42))
print("tostring(true):", tostring(true))
print("tostring(nil):", tostring(nil))

print("\nCoercion:")
print("'10' + 5 =", "10" + 5)
print("'20' * 2 =", "20" * 2)
print("42 .. ' answer' =", 42 .. " answer")

local function to_boolean(value)
    return not not value
end

print("\nBoolean Conversion:")
print("to_boolean(1):", to_boolean(1))
print("to_boolean(0):", to_boolean(0))
print("to_boolean(''):", to_boolean(""))
print("to_boolean(nil):", to_boolean(nil))

local function parse_boolean(value)
    if type(value) == "boolean" then return value
    elseif type(value) == "string" then
        local lower = string.lower(value)
        if lower == "true" or lower == "yes" or lower == "1" then return true
        elseif lower == "false" or lower == "no" or lower == "0" then return false end
    elseif type(value) == "number" then return value ~= 0 end
    return nil
end

print("\nParse Boolean:")
print("parse_boolean('true'):", parse_boolean("true"))
print("parse_boolean('false'):", parse_boolean("false"))
print("parse_boolean(1):", parse_boolean(1))

local function to_hex(num) return string.format("%X", num) end
local function from_hex(str) return tonumber(str, 16) end

print("\nHex Conversion:")
print("to_hex(255):", to_hex(255))
print("from_hex('FF'):", from_hex("FF"))

if math.type then
    print("\nInteger vs Float:")
    print("math.type(42):", math.type(42))
    print("math.type(42.5):", math.type(42.5))
end
