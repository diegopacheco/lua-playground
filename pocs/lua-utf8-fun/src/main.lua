print("=== UTF-8 Length ===")
local str = "Hello, 世界"
print("String:", str)
print("Byte length:", #str)
print("UTF-8 length:", utf8.len(str))

print("\n=== UTF-8 Codepoints ===")
local text = "Café"
print("Text:", text)
for pos, code in utf8.codes(text) do
    print("Position:", pos, "Codepoint:", code, "Char:", utf8.char(code))
end

print("\n=== UTF-8 Character Iteration ===")
local emoji = "🚀 Lua 🌙"
print("String:", emoji)
print("Characters:")
for pos, code in utf8.codes(emoji) do
    print("  ", utf8.char(code))
end

print("\n=== UTF-8 Offset ===")
local sample = "Ñoño"
print("String:", sample)
print("Offset of 1st char:", utf8.offset(sample, 1))
print("Offset of 2nd char:", utf8.offset(sample, 2))
print("Offset of 3rd char:", utf8.offset(sample, 3))
print("Offset of 4th char:", utf8.offset(sample, 4))

print("\n=== UTF-8 Char to Codepoint ===")
local chars = "日本語"
print("String:", chars)
for pos, code in utf8.codes(chars) do
    print("Codepoint:", code, "Hex:", string.format("U+%04X", code))
end

print("\n=== UTF-8 Char Construction ===")
local constructed = utf8.char(72, 101, 108, 108, 111)
print("From codepoints [72,101,108,108,111]:", constructed)

local unicode_str = utf8.char(0x4E16, 0x754C)
print("From unicode [U+4E16, U+754C]:", unicode_str)

print("\n=== UTF-8 Validation ===")
local valid = "Hello"
local valid_len = utf8.len(valid)
print("Valid string length:", valid_len)

local invalid = "Hello\xFF\xFE"
local invalid_len, pos = utf8.len(invalid)
if not invalid_len then
    print("Invalid UTF-8 at position:", pos)
end

print("\n=== UTF-8 Substring ===")
local long_str = "Привет, мир!"
print("Original:", long_str)
local start_pos = utf8.offset(long_str, 1)
local end_pos = utf8.offset(long_str, 7)
local substring = string.sub(long_str, start_pos, end_pos - 1)
print("First 6 chars:", substring)

print("\n=== UTF-8 Reverse Iteration ===")
local rev = "ABC"
print("String:", rev)
local len = utf8.len(rev)
print("Reverse:")
for i = len, 1, -1 do
    local pos = utf8.offset(rev, i)
    local next_pos = utf8.offset(rev, i + 1)
    if next_pos then
        print("  ", string.sub(rev, pos, next_pos - 1))
    else
        print("  ", string.sub(rev, pos))
    end
end

print("\n=== UTF-8 Character Count by Type ===")
local mixed = "Hello123你好456"
print("String:", mixed)
local ascii_count = 0
local unicode_count = 0

for pos, code in utf8.codes(mixed) do
    if code < 128 then
        ascii_count = ascii_count + 1
    else
        unicode_count = unicode_count + 1
    end
end

print("ASCII characters:", ascii_count)
print("Non-ASCII characters:", unicode_count)

print("\n=== UTF-8 Upper/Lower Case ===")
local lower = "hello"
local upper = "HELLO"
print("Lower:", string.lower(lower))
print("Upper:", string.upper(lower))
print("Lower of upper:", string.lower(upper))

print("\n=== UTF-8 Find Characters ===")
local search = "The quick brown fox"
for pos, code in utf8.codes(search) do
    if utf8.char(code) == "o" then
        print("Found 'o' at position:", pos)
    end
end

print("\n=== UTF-8 Codepoint Ranges ===")
local multi = "Aא中🎨"
for pos, code in utf8.codes(multi) do
    local char = utf8.char(code)
    if code < 0x80 then
        print(char, "is ASCII")
    elseif code < 0x800 then
        print(char, "is 2-byte UTF-8")
    elseif code < 0x10000 then
        print(char, "is 3-byte UTF-8")
    else
        print(char, "is 4-byte UTF-8")
    end
end

print("\n=== UTF-8 Normalization Check ===")
local test1 = "é"
local test2 = "é"
print("String 1 length:", utf8.len(test1))
print("String 2 length:", utf8.len(test2))
print("Are equal:", test1 == test2)
