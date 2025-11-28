print("=== Producer Consumer ===")
local function producer()
    for i = 1, 5 do
        print("Producing:", i)
        coroutine.yield(i)
    end
end

local function consumer(prod)
    while true do
        local status, value = coroutine.resume(prod)
        if not status or value == nil then break end
        print("Consuming:", value)
    end
end

local prod_co = coroutine.create(producer)
consumer(prod_co)

print("\n=== Coroutine Pipeline ===")
local function source(max)
    return coroutine.create(function()
        for i = 1, max do
            coroutine.yield(i)
        end
    end)
end

local function filter(src, predicate)
    return coroutine.create(function()
        while true do
            local status, value = coroutine.resume(src)
            if not status or value == nil then break end
            if predicate(value) then
                coroutine.yield(value)
            end
        end
    end)
end

local function map(src, func)
    return coroutine.create(function()
        while true do
            local status, value = coroutine.resume(src)
            if not status or value == nil then break end
            coroutine.yield(func(value))
        end
    end)
end

local src = source(10)
local evens = filter(src, function(x) return x % 2 == 0 end)
local doubled = map(evens, function(x) return x * 2 end)

print("Pipeline output:")
while true do
    local status, value = coroutine.resume(doubled)
    if not status or value == nil then break end
    print("  ", value)
end

print("\n=== Fibonacci Generator ===")
local function fibonacci()
    return coroutine.create(function()
        local a, b = 0, 1
        while true do
            coroutine.yield(a)
            a, b = b, a + b
        end
    end)
end

local fib = fibonacci()
print("First 10 Fibonacci numbers:")
for i = 1, 10 do
    local status, value = coroutine.resume(fib)
    print("  ", i, value)
end

print("\n=== Coroutine Status ===")
local co = coroutine.create(function()
    coroutine.yield("first")
    coroutine.yield("second")
    return "done"
end)

print("Initial status:", coroutine.status(co))
coroutine.resume(co)
print("After first resume:", coroutine.status(co))
coroutine.resume(co)
print("After second resume:", coroutine.status(co))
coroutine.resume(co)
print("After completion:", coroutine.status(co))

print("\n=== Bidirectional Communication ===")
local function receiver()
    local value
    while true do
        value = coroutine.yield(value and value * 2 or nil)
        print("Received:", value)
    end
end

local recv = coroutine.create(receiver)
coroutine.resume(recv)
print("Sent 5, got back:", select(2, coroutine.resume(recv, 5)))
print("Sent 10, got back:", select(2, coroutine.resume(recv, 10)))
print("Sent 15, got back:", select(2, coroutine.resume(recv, 15)))

print("\n=== Iterator from Coroutine ===")
local function permgen(a, n)
    n = n or #a
    if n <= 1 then
        coroutine.yield(a)
    else
        for i = 1, n do
            a[n], a[i] = a[i], a[n]
            permgen(a, n - 1)
            a[n], a[i] = a[i], a[n]
        end
    end
end

local function permutations(a)
    local co = coroutine.create(function()
        permgen(a)
    end)
    return function()
        local code, res = coroutine.resume(co)
        return res
    end
end

print("Permutations of {1,2,3}:")
local count = 0
for p in permutations({1, 2, 3}) do
    count = count + 1
    print("  ", table.concat(p, ","))
    if count >= 6 then break end
end

print("\n=== Cooperative Multitasking ===")
local tasks = {}

local function add_task(func)
    table.insert(tasks, coroutine.create(func))
end

local function run_tasks()
    while #tasks > 0 do
        for i = #tasks, 1, -1 do
            local status = coroutine.resume(tasks[i])
            if coroutine.status(tasks[i]) == "dead" then
                table.remove(tasks, i)
            end
        end
    end
end

add_task(function()
    for i = 1, 3 do
        print("Task 1 step", i)
        coroutine.yield()
    end
end)

add_task(function()
    for i = 1, 3 do
        print("Task 2 step", i)
        coroutine.yield()
    end
end)

run_tasks()

print("\n=== Range Generator ===")
local function range(from, to, step)
    step = step or 1
    return coroutine.create(function()
        local current = from
        while (step > 0 and current <= to) or (step < 0 and current >= to) do
            coroutine.yield(current)
            current = current + step
        end
    end)
end

local r = range(1, 10, 2)
print("Range 1 to 10 step 2:")
while true do
    local status, value = coroutine.resume(r)
    if not status or value == nil then break end
    print("  ", value)
end

print("\n=== Tree Traversal ===")
local tree = {
    value = 1,
    left = {
        value = 2,
        left = {value = 4},
        right = {value = 5}
    },
    right = {
        value = 3,
        left = {value = 6},
        right = {value = 7}
    }
}

local function traverse(node)
    if not node then return end
    coroutine.yield(node.value)
    traverse(node.left)
    traverse(node.right)
end

local function tree_iterator(root)
    local co = coroutine.create(function()
        traverse(root)
    end)
    return function()
        local status, value = coroutine.resume(co)
        if status then return value end
    end
end

print("Tree traversal:")
for value in tree_iterator(tree) do
    print("  ", value)
end

print("\n=== Lazy Evaluation ===")
local function lazy_map(func, list)
    return coroutine.create(function()
        for _, v in ipairs(list) do
            coroutine.yield(func(v))
        end
    end)
end

local numbers = {1, 2, 3, 4, 5}
local squares = lazy_map(function(x) return x * x end, numbers)

print("Lazy squares:")
for i = 1, 3 do
    local status, value = coroutine.resume(squares)
    print("  ", value)
end

print("\n=== Coroutine Wrap ===")
local function counter_func()
    local i = 0
    while true do
        i = i + 1
        coroutine.yield(i)
    end
end

local counter = coroutine.wrap(counter_func)
print("Counter:")
print("  ", counter())
print("  ", counter())
print("  ", counter())

print("\n=== State Machine ===")
local function state_machine()
    local state = "IDLE"
    while true do
        local event = coroutine.yield(state)
        if state == "IDLE" and event == "start" then
            state = "RUNNING"
        elseif state == "RUNNING" and event == "pause" then
            state = "PAUSED"
        elseif state == "PAUSED" and event == "resume" then
            state = "RUNNING"
        elseif state == "RUNNING" and event == "stop" then
            state = "IDLE"
        end
    end
end

local sm = coroutine.create(state_machine)
coroutine.resume(sm)
print("State:", select(2, coroutine.resume(sm, "start")))
print("State:", select(2, coroutine.resume(sm, "pause")))
print("State:", select(2, coroutine.resume(sm, "resume")))
print("State:", select(2, coroutine.resume(sm, "stop")))

print("\n=== Download Simulator ===")
local function download(name, size)
    return coroutine.create(function()
        for i = 0, size, 10 do
            print(name .. " progress:", i .. "%")
            coroutine.yield()
        end
        print(name .. " complete")
    end)
end

local downloads = {
    download("File1", 100),
    download("File2", 100),
    download("File3", 100)
}

local active = #downloads
while active > 0 do
    for i = #downloads, 1, -1 do
        if coroutine.status(downloads[i]) ~= "dead" then
            coroutine.resume(downloads[i])
        end
        if coroutine.status(downloads[i]) == "dead" then
            active = active - 1
        end
    end
end

print("\n=== Running Coroutine ===")
local function check_running()
    print("Is running:", coroutine.running() ~= nil)
    local co = coroutine.create(function()
        print("Inside coroutine:", coroutine.running() ~= nil)
    end)
    coroutine.resume(co)
end

check_running()

print("\n=== Yield from Main ===")
local function try_yield_main()
    local status, err = pcall(function()
        coroutine.yield()
    end)
    if not status then
        print("Cannot yield from main:", err:match("cannot") ~= nil)
    end
end

try_yield_main()
