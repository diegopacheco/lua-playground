print("File I/O Operations")

local function write_file(filename, content)
    local file = io.open(filename, "w")
    file:write(content)
    file:close()
end

local function read_file(filename)
    local file = io.open(filename, "r")
    local content = file:read("*a")
    file:close()
    return content
end

local function append_file(filename, content)
    local file = io.open(filename, "a")
    file:write(content)
    file:close()
end

local function file_exists(name)
    local f = io.open(name, "r")
    if f then f:close(); return true end
    return false
end

print("\nWrite to file:")
write_file("/tmp/test.txt", "Hello, Lua!\nLine 2\nLine 3\n")
print("File written to /tmp/test.txt")

print("\nRead file:")
print(read_file("/tmp/test.txt"))

print("Append to file:")
append_file("/tmp/test.txt", "Appended line\n")
print("Line appended")

print("\nRead after append:")
print(read_file("/tmp/test.txt"))

print("File exists check:")
print("test.txt exists:", file_exists("/tmp/test.txt"))
print("nonexistent.txt exists:", file_exists("/tmp/nonexistent.txt"))
