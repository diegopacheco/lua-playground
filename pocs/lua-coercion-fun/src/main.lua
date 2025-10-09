print("=== String to Number Coercion ===")
local str_num = "123"
local result = str_num + 10
print("'123' + 10 =", result)
print("Type:", type(result))

local float_str = "3.14"
print("'3.14' * 2 =", float_str * 2)

print("\n=== Number to String Coercion ===")
local num = 42
local concat_result = num .. " is the answer"
print("Concatenation:", concat_result)
print("Type:", type(concat_result))

print("\n=== Implicit Conversions ===")
print("'10' + '20' =", '10' + '20')
print("'5.5' - 2 =", '5.5' - 2)
print("'8' * '7' =", '8' * '7')
print("'100' / '4' =", '100' / '4')

print("\n=== Explicit Conversions ===")
local to_num = tonumber("456")
print("tonumber('456'):", to_num, type(to_num))

local to_str = tostring(789)
print("tostring(789):", to_str, type(to_str))

print("\n=== Failed Coercions ===")
local invalid = tonumber("abc")
print("tonumber('abc'):", invalid)

local mixed = tonumber("123abc")
print("tonumber('123abc'):", mixed)

print("\n=== Hexadecimal Conversion ===")
local hex = tonumber("FF", 16)
print("tonumber('FF', 16):", hex)

local binary = tonumber("1010", 2)
print("tonumber('1010', 2):", binary)

local octal = tonumber("77", 8)
print("tonumber('77', 8):", octal)

print("\n=== Boolean to String ===")
local bool_true = tostring(true)
local bool_false = tostring(false)
print("tostring(true):", bool_true, type(bool_true))
print("tostring(false):", bool_false, type(bool_false))

print("\n=== Nil Coercion ===")
local nil_str = tostring(nil)
print("tostring(nil):", nil_str)

print("\n=== Table Coercion ===")
local t = {1, 2, 3}
print("tostring(table):", tostring(t))

print("\n=== Function Coercion ===")
local f = function() end
print("tostring(function):", tostring(f))

print("\n=== Arithmetic with Strings ===")
local a = "10"
local b = "3"
print("String arithmetic:")
print("  a + b =", a + b)
print("  a - b =", a - b)
print("  a * b =", a * b)
print("  a / b =", a / b)
print("  a % b =", a % b)
print("  a ^ b =", a ^ b)

print("\n=== Edge Cases ===")
print("Empty string to number:", tonumber(""))
print("Whitespace to number:", tonumber("  123  "))
print("Leading zeros:", tonumber("00123"))
print("Scientific notation:", tonumber("1e3"))
print("Negative scientific:", tonumber("-2.5e-2"))

print("\n=== Comparison Coercion ===")
print("'10' == 10:", '10' == 10)
print("10 == 10:", 10 == 10)
print("'10' < '9':", '10' < '9')
print("10 < 9:", 10 < 9)

print("\n=== Concatenation Edge Cases ===")
print("true .. 'test':", tostring(true) .. 'test')
print("nil concatenation:", tostring(nil) .. 'value')

print("\n=== Type Checking ===")
local value = "123"
print("Value:", value)
print("type(value):", type(value))
print("type(tonumber(value)):", type(tonumber(value)))

print("\n=== Float to Integer ===")
local float = 3.14
print("math.floor(3.14):", math.floor(float))
print("math.ceil(3.14):", math.ceil(float))
print("math.modf(3.14):", math.modf(float))

print("\n=== String Format Conversions ===")
local formatted = string.format("%d", 42.7)
print("string.format('%d', 42.7):", formatted)

local hex_format = string.format("%x", 255)
print("string.format('%x', 255):", hex_format)

local float_format = string.format("%.2f", 3.14159)
print("string.format('%.2f', 3.14159):", float_format)
