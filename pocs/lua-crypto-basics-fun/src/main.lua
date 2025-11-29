local function xor_cipher(text, key)
    local result = {}
    for i = 1, #text do
        local text_byte = string.byte(text, i)
        local key_byte = string.byte(key, ((i - 1) % #key) + 1)
        table.insert(result, string.char(text_byte ~ key_byte))
    end
    return table.concat(result)
end

local function base64_encode(data)
    local b64chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    local result = {}
    for i = 1, #data, 3 do
        local b1, b2, b3 = string.byte(data, i), string.byte(data, i + 1) or 0, string.byte(data, i + 2) or 0
        local n = (b1 << 16) + (b2 << 8) + b3
        table.insert(result, b64chars:sub(((n >> 18) & 63) + 1, ((n >> 18) & 63) + 1))
        table.insert(result, b64chars:sub(((n >> 12) & 63) + 1, ((n >> 12) & 63) + 1))
        table.insert(result, i + 1 <= #data and b64chars:sub(((n >> 6) & 63) + 1, ((n >> 6) & 63) + 1) or "=")
        table.insert(result, i + 2 <= #data and b64chars:sub((n & 63) + 1, (n & 63) + 1) or "=")
    end
    return table.concat(result)
end

local function djb2_hash(text)
    local hash = 5381
    for i = 1, #text do
        hash = ((hash << 5) + hash) + string.byte(text, i)
        hash = hash & 0xFFFFFFFF
    end
    return hash
end

print("XOR Cipher:")
local msg, key = "Hello World", "secret"
local encrypted = xor_cipher(msg, key)
print("Encrypted:", encrypted:byte(1, -1))
print("Decrypted:", xor_cipher(encrypted, key))

print("\nBase64:")
print("Encoded:", base64_encode("Hello World"))

print("\nDJB2 Hash:")
print("Hash:", djb2_hash("test"))
