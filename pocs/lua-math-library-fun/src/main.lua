print("Basic Math Operations:")
print("abs(-10):", math.abs(-10))
print("ceil(4.2):", math.ceil(4.2))
print("floor(4.8):", math.floor(4.8))
print("max(10, 20, 5):", math.max(10, 20, 5))
print("min(10, 20, 5):", math.min(10, 20, 5))

print("\nPower and Roots:")
print("2 ^ 8:", 2 ^ 8)
print("sqrt(16):", math.sqrt(16))
print("sqrt(100):", math.sqrt(100))

print("\nTrigonometry:")
print("sin(pi/2):", math.sin(math.pi / 2))
print("cos(0):", math.cos(0))
print("tan(pi/4):", math.tan(math.pi / 4))
print("deg(pi):", math.deg(math.pi))
print("rad(180):", math.rad(180))

print("\nRandom:")
math.randomseed(12345)
print("random():", math.random())
print("random(10):", math.random(10))
print("random(5, 15):", math.random(5, 15))

print("\nUtility:")
local int, frac = math.modf(3.14159)
print("modf(3.14159): int =", int, "frac =", frac)
print("fmod(7, 3):", math.fmod(7, 3))

print("\nConstants:")
print("pi:", math.pi)
print("huge:", math.huge)

local function distance(x1, y1, x2, y2)
    local dx, dy = x2 - x1, y2 - y1
    return math.sqrt(dx * dx + dy * dy)
end

print("\nDistance (0,0) to (3,4):", distance(0, 0, 3, 4))

local function clamp(value, min_val, max_val)
    return math.max(min_val, math.min(max_val, value))
end

print("Clamp 15 to [0,10]:", clamp(15, 0, 10))
