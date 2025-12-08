local Vec2 = {}
Vec2.__index = Vec2

function Vec2.new(x, y)
    return setmetatable({x = x, y = y}, Vec2)
end

Vec2.__add = function(a, b) return Vec2.new(a.x + b.x, a.y + b.y) end
Vec2.__sub = function(a, b) return Vec2.new(a.x - b.x, a.y - b.y) end
Vec2.__mul = function(a, b)
    if type(a) == "number" then return Vec2.new(a * b.x, a * b.y)
    elseif type(b) == "number" then return Vec2.new(a.x * b, a.y * b)
    else return Vec2.new(a.x * b.x, a.y * b.y) end
end
Vec2.__div = function(a, b)
    if type(b) == "number" then return Vec2.new(a.x / b, a.y / b)
    else return Vec2.new(a.x / b.x, a.y / b.y) end
end
Vec2.__unm = function(a) return Vec2.new(-a.x, -a.y) end
Vec2.__eq = function(a, b) return a.x == b.x and a.y == b.y end
Vec2.__lt = function(a, b) return a.x < b.x and a.y < b.y end
Vec2.__tostring = function(a) return "Vector(" .. a.x .. ", " .. a.y .. ")" end

print("Vector Operations:")
local v1 = Vec2.new(1, 2)
local v2 = Vec2.new(3, 4)
print("v1:", v1)
print("v2:", v2)
print("v1 + v2:", v1 + v2)
print("v2 - v1:", v2 - v1)
print("v1 * 3:", v1 * 3)
print("v2 / 2:", v2 / 2)
print("-v1:", -v1)
print("v1 == Vec2.new(1,2):", v1 == Vec2.new(1, 2))

local function lazy_table(compute)
    return setmetatable({}, {
        __index = function(t, k)
            local v = compute(k)
            rawset(t, k, v)
            return v
        end
    })
end

print("\nLazy Table:")
local powers = lazy_table(function(n) return n * n end)
print("powers[5]:", powers[5])
print("powers[10]:", powers[10])
