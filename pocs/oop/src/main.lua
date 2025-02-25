local Rectangle = {}
Rectangle.__index = Rectangle

function Rectangle.new(width, height)
    local self = setmetatable({}, Rectangle)
    self.width = width or 0
    self.height = height or 0
    return self
end

function Rectangle:area()
    return self.width * self.height
end

function Rectangle:perimeter()
    return 2 * (self.width + self.height)
end

local rect = Rectangle.new(5, 3)
print("Rectangle area: " .. rect:area())
print("Rectangle perimeter: " .. rect:perimeter())