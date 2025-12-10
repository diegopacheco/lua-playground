print("Basic Pattern Matching:")
local text = "The year is 2024"
print("Year:", string.match(text, "%d+"))
print("First word:", string.match("Hello World", "%a+"))

print("\nCharacter Classes:")
local str = "abc123XYZ"
print("Letters:", string.match(str, "%a+"))
print("Digits:", string.match(str, "%d+"))
print("Uppercase:", string.match(str, "%u+"))

print("\nMultiple Matches:")
for word in string.gmatch("The quick brown fox", "%a+") do
    print("  ", word)
end

print("\nCaptures:")
local date = "2024-10-05"
local year, month, day = string.match(date, "(%d+)-(%d+)-(%d+)")
print("Year:", year, "Month:", month, "Day:", day)

print("\nEmail Pattern:")
local email = "user@example.com"
local username, domain = string.match(email, "([%w%.]+)@([%w%.]+)")
print("Username:", username, "Domain:", domain)

print("\nReplacement:")
local original = "hello world"
print("Replaced:", string.gsub(original, "world", "Lua"))

local numbers = "1 2 3 4 5"
local doubled = string.gsub(numbers, "%d+", function(n) return tostring(tonumber(n) * 2) end)
print("Doubled:", doubled)

print("\nFind Pattern:")
local data = "Item: 12345"
local start, finish = string.find(data, "%d+")
print("Number at:", start, "-", finish)
print("Number is:", string.sub(data, start, finish))

print("\nSplit String:")
local csv = "apple,banana,cherry"
print("CSV split:")
for item in string.gmatch(csv, "[^,]+") do
    print("  ", item)
end

print("\nIP Parser:")
local ip = "192.168.1.1"
local o1, o2, o3, o4 = string.match(ip, "(%d+)%.(%d+)%.(%d+)%.(%d+)")
print("IP octets:", o1, o2, o3, o4)
