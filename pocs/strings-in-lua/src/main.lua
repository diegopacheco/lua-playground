s = "hello world"
i, j = string.find(s, "hello")
print("find in s("..s..") result i="..i.." - j="..j)

s = string.gsub("Lua is cute", "cute", "great")
print(s)         --> Lua is great

str = " this is a string "
 _, count = string.gsub(str, " ", " ")
 print(count)
