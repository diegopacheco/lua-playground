print("String Length:")
print("#'Hello':", #"Hello")
print("string.len('World'):", string.len("World"))

print("\nString Operations:")
print("upper('hello'):", string.upper("hello"))
print("lower('WORLD'):", string.lower("WORLD"))
print("reverse('hello'):", string.reverse("hello"))
print("rep('Ha', 3):", string.rep("Ha", 3))

print("\nSubstring:")
local text = "Lua Programming"
print("sub(1, 3):", string.sub(text, 1, 3))
print("sub(5, 15):", string.sub(text, 5, 15))
print("sub(-11):", string.sub(text, -11))

print("\nByte and Char:")
print("byte('A'):", string.byte("A"))
print("char(65, 66, 67):", string.char(65, 66, 67))

print("\nFormat:")
print("format('%d', 42):", string.format("%d", 42))
print("format('%.2f', 3.14159):", string.format("%.2f", 3.14159))
print("format('%s: %d', 'Age', 30):", string.format("%s: %d", "Age", 30))

print("\nPack and Unpack:")
local packed = string.pack("iii", 10, 20, 30)
print("Packed length:", #packed)
local a, b, c = string.unpack("iii", packed)
print("Unpacked:", a, b, c)

local function trim(s)
    return string.match(s, "^%s*(.-)%s*$")
end

local function split(s, delimiter)
    local result = {}
    local pattern = string.format("([^%s]+)", delimiter)
    for match in string.gmatch(s, pattern) do table.insert(result, match) end
    return result
end

print("\nUtility:")
print("Trim '  hello  ':", "'" .. trim("  hello  ") .. "'")
print("Split 'a,b,c':")
for i, part in ipairs(split("apple,banana,cherry", ",")) do
    print("  ", i, part)
end

print("\nHex Conversion:")
local function to_hex(str)
    return (string.gsub(str, ".", function(c) return string.format("%02x", string.byte(c)) end))
end
print("Hex of 'ABC':", to_hex("ABC"))
