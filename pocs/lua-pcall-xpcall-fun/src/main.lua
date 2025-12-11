print("Basic pcall:")
local status, result = pcall(function() return "success" end)
print("Status:", status, "Result:", result)

print("\npcall with Error:")
status, result = pcall(function() error("Something wrong") end)
print("Status:", status, "Error:", result)

print("\npcall with Arguments:")
local function divide(a, b)
    if b == 0 then error("Division by zero") end
    return a / b
end

status, result = pcall(divide, 10, 2)
print("10 / 2:", status, result)

status, result = pcall(divide, 10, 0)
print("10 / 0:", status, result)

print("\nxpcall with Handler:")
local function error_handler(err)
    return "Handled: " .. tostring(err)
end

status, result = xpcall(function() error("Critical") end, error_handler)
print("Status:", status, "Result:", result)

print("\nRetry Logic:")
local attempts = 0
local function unreliable()
    attempts = attempts + 1
    if attempts < 3 then error("Not yet") end
    return "Worked!"
end

local function retry(func, max_attempts)
    for i = 1, max_attempts do
        local status, result = pcall(func)
        if status then return true, result end
        print("Attempt", i, "failed")
    end
    return false, "Max retries"
end

local success, msg = retry(unreliable, 5)
print("Final:", success, msg)

print("\nSafe Function Call:")
local function safe_call(func, ...)
    local args = {...}
    local status, result = pcall(function() return func(table.unpack(args)) end)
    return status, result
end

local ok, res = safe_call(divide, 20, 4)
print("Safe 20/4:", ok, res)

ok, res = safe_call(divide, 20, 0)
print("Safe 20/0:", ok, res)
