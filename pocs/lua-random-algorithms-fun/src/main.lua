math.randomseed(os.time())

local function shuffle(list)
    local result = {}
    for i, v in ipairs(list) do result[i] = v end
    for i = #result, 2, -1 do
        local j = math.random(1, i)
        result[i], result[j] = result[j], result[i]
    end
    return result
end

local function choice(list)
    return list[math.random(1, #list)]
end

local function weighted_choice(items, weights)
    local total = 0
    for _, w in ipairs(weights) do total = total + w end
    local rand, cumsum = math.random() * total, 0
    for i, item in ipairs(items) do
        cumsum = cumsum + weights[i]
        if rand <= cumsum then return item end
    end
    return items[#items]
end

local function random_string(length, charset)
    charset = charset or "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local result = {}
    for i = 1, length do
        local idx = math.random(1, #charset)
        table.insert(result, charset:sub(idx, idx))
    end
    return table.concat(result)
end

local function random_normal(mean, stddev)
    mean, stddev = mean or 0, stddev or 1
    local u1, u2 = math.random(), math.random()
    local z0 = math.sqrt(-2 * math.log(u1)) * math.cos(2 * math.pi * u2)
    return z0 * stddev + mean
end

print("Shuffle:")
print(table.concat(shuffle({1, 2, 3, 4, 5, 6, 7, 8}), ", "))

print("\nRandom Choice:")
print("Color:", choice({"red", "green", "blue", "yellow"}))

print("\nWeighted Choice:")
for i = 1, 5 do
    print("  ", weighted_choice({"common", "rare", "legendary"}, {70, 25, 5}))
end

print("\nRandom String:")
print("String:", random_string(10))

print("\nNormal Distribution:")
for i = 1, 5 do
    print("  ", string.format("%.2f", random_normal(100, 15)))
end
