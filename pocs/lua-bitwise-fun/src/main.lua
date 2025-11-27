print("=== Bitwise AND ===")
local a = 12
local b = 10
print("12 & 10 =", a & b)
print("Binary: 1100 & 1010 =", string.format("%04d", tonumber(tostring(a & b), 2) or 0))

print("\n=== Bitwise OR ===")
print("12 | 10 =", a | b)
print("Binary: 1100 | 1010 =", string.format("%d", a | b))

print("\n=== Bitwise XOR ===")
print("12 ~ 10 =", a ~ b)
print("Binary: 1100 ~ 1010 =", a ~ b)

print("\n=== Bitwise NOT ===")
local x = 5
print("~5 =", ~x)
print("~0 =", ~0)
print("~(-1) =", ~(-1))

print("\n=== Left Shift ===")
local n = 1
print("1 << 0 =", n << 0)
print("1 << 1 =", n << 1)
print("1 << 2 =", n << 2)
print("1 << 3 =", n << 3)
print("1 << 4 =", n << 4)

print("\n=== Right Shift ===")
local m = 16
print("16 >> 0 =", m >> 0)
print("16 >> 1 =", m >> 1)
print("16 >> 2 =", m >> 2)
print("16 >> 3 =", m >> 3)
print("16 >> 4 =", m >> 4)

print("\n=== Check Bit Set ===")
local function is_bit_set(num, bit)
    return (num & (1 << bit)) ~= 0
end

local flags = 22
print("Flags:", flags)
print("Bit 0 set:", is_bit_set(flags, 0))
print("Bit 1 set:", is_bit_set(flags, 1))
print("Bit 2 set:", is_bit_set(flags, 2))
print("Bit 3 set:", is_bit_set(flags, 3))
print("Bit 4 set:", is_bit_set(flags, 4))

print("\n=== Set Bit ===")
local function set_bit(num, bit)
    return num | (1 << bit)
end

local val = 0
val = set_bit(val, 0)
print("Set bit 0:", val)
val = set_bit(val, 2)
print("Set bit 2:", val)
val = set_bit(val, 4)
print("Set bit 4:", val)

print("\n=== Clear Bit ===")
local function clear_bit(num, bit)
    return num & ~(1 << bit)
end

val = 31
print("Initial:", val)
val = clear_bit(val, 1)
print("Clear bit 1:", val)
val = clear_bit(val, 3)
print("Clear bit 3:", val)

print("\n=== Toggle Bit ===")
local function toggle_bit(num, bit)
    return num ~ (1 << bit)
end

val = 21
print("Initial:", val)
val = toggle_bit(val, 0)
print("Toggle bit 0:", val)
val = toggle_bit(val, 2)
print("Toggle bit 2:", val)

print("\n=== Extract Bits ===")
local function extract_bits(num, start, count)
    local mask = (1 << count) - 1
    return (num >> start) & mask
end

local data = 214
print("Data:", data)
print("Bits 0-2:", extract_bits(data, 0, 3))
print("Bits 2-4:", extract_bits(data, 2, 3))
print("Bits 4-7:", extract_bits(data, 4, 4))

print("\n=== Count Set Bits ===")
local function count_bits(num)
    local count = 0
    while num ~= 0 do
        count = count + 1
        num = num & (num - 1)
    end
    return count
end

print("Bits in 10:", count_bits(10))
print("Bits in 15:", count_bits(15))
print("Bits in 170:", count_bits(170))

print("\n=== Parity Check ===")
local function parity(num)
    local p = 0
    while num ~= 0 do
        p = p ~ 1
        num = num & (num - 1)
    end
    return p
end

print("Parity of 7:", parity(7))
print("Parity of 10:", parity(10))
print("Parity of 255:", parity(255))

print("\n=== Reverse Bits ===")
local function reverse_bits(num, bits)
    local result = 0
    for i = 0, bits - 1 do
        if (num & (1 << i)) ~= 0 then
            result = result | (1 << (bits - 1 - i))
        end
    end
    return result
end

print("Reverse 12 (4 bits):", reverse_bits(12, 4))
print("Reverse 22 (5 bits):", reverse_bits(22, 5))
print("Reverse 240 (8 bits):", reverse_bits(240, 8))

print("\n=== Swap Values ===")
local function swap_xor(a, b)
    a = a ~ b
    b = a ~ b
    a = a ~ b
    return a, b
end

local x1, y1 = 10, 20
x1, y1 = swap_xor(x1, y1)
print("After swap: x =", x1, "y =", y1)

print("\n=== Power of Two ===")
local function is_power_of_two(num)
    return num > 0 and (num & (num - 1)) == 0
end

print("4 is power of 2:", is_power_of_two(4))
print("5 is power of 2:", is_power_of_two(5))
print("16 is power of 2:", is_power_of_two(16))
print("18 is power of 2:", is_power_of_two(18))

print("\n=== Next Power of Two ===")
local function next_power_of_two(num)
    num = num - 1
    num = num | (num >> 1)
    num = num | (num >> 2)
    num = num | (num >> 4)
    num = num | (num >> 8)
    num = num | (num >> 16)
    return num + 1
end

print("Next power after 5:", next_power_of_two(5))
print("Next power after 17:", next_power_of_two(17))
print("Next power after 100:", next_power_of_two(100))

print("\n=== Isolate Rightmost Bit ===")
local function rightmost_bit(num)
    return num & (-num)
end

print("Rightmost bit of 12:", rightmost_bit(12))
print("Rightmost bit of 20:", rightmost_bit(20))
print("Rightmost bit of 7:", rightmost_bit(7))

print("\n=== Clear Rightmost Bit ===")
local function clear_rightmost(num)
    return num & (num - 1)
end

print("Clear rightmost of 12:", clear_rightmost(12))
print("Clear rightmost of 7:", clear_rightmost(7))

print("\n=== Rotate Left ===")
local function rotate_left(num, shift, bits)
    bits = bits or 8
    shift = shift % bits
    return ((num << shift) | (num >> (bits - shift))) & ((1 << bits) - 1)
end

print("Rotate 192 left 2:", rotate_left(192, 2, 8))
print("Rotate 129 left 1:", rotate_left(129, 1, 8))

print("\n=== Rotate Right ===")
local function rotate_right(num, shift, bits)
    bits = bits or 8
    shift = shift % bits
    return ((num >> shift) | (num << (bits - shift))) & ((1 << bits) - 1)
end

print("Rotate 3 right 2:", rotate_right(3, 2, 8))
print("Rotate 129 right 1:", rotate_right(129, 1, 8))

print("\n=== Sign Extension ===")
local function sign_extend(num, bits)
    local sign_bit = 1 << (bits - 1)
    if (num & sign_bit) ~= 0 then
        num = num | (~((1 << bits) - 1))
    end
    return num
end

print("Sign extend 15 (4-bit):", sign_extend(15, 4))
print("Sign extend 7 (4-bit):", sign_extend(7, 4))

print("\n=== Bit Mask Operations ===")
local READ = 1 << 0
local WRITE = 1 << 1
local EXECUTE = 1 << 2

local permissions = 0
permissions = permissions | READ
permissions = permissions | EXECUTE
print("Has READ:", (permissions & READ) ~= 0)
print("Has WRITE:", (permissions & WRITE) ~= 0)
print("Has EXECUTE:", (permissions & EXECUTE) ~= 0)

print("\n=== Gray Code ===")
local function to_gray(num)
    return num ~ (num >> 1)
end

local function from_gray(num)
    local result = num
    while num ~= 0 do
        num = num >> 1
        result = result ~ num
    end
    return result
end

print("Gray code of 5:", to_gray(5))
print("From gray 6:", from_gray(6))
