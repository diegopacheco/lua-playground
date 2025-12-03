local function map(func, list)
    local result = {}
    for i, v in ipairs(list) do result[i] = func(v) end
    return result
end

local function filter(predicate, list)
    local result = {}
    for _, v in ipairs(list) do if predicate(v) then table.insert(result, v) end end
    return result
end

local function reduce(func, list, initial)
    local acc = initial
    for _, v in ipairs(list) do acc = func(acc, v) end
    return acc
end

local function compose(...)
    local funcs = {...}
    return function(x)
        local result = x
        for i = #funcs, 1, -1 do result = funcs[i](result) end
        return result
    end
end

local function curry(func, arity)
    local function curried(args)
        return function(...)
            local new_args = {table.unpack(args)}
            for _, v in ipairs({...}) do table.insert(new_args, v) end
            if #new_args >= arity then return func(table.unpack(new_args))
            else return curried(new_args) end
        end
    end
    return curried({})
end

local numbers = {1, 2, 3, 4, 5}
print("Map (x2):", table.concat(map(function(x) return x * 2 end, numbers), ", "))
print("Filter (even):", table.concat(filter(function(x) return x % 2 == 0 end, numbers), ", "))
print("Reduce (sum):", reduce(function(acc, x) return acc + x end, numbers, 0))

local add5 = function(x) return x + 5 end
local mult2 = function(x) return x * 2 end
local composed = compose(add5, mult2)
print("Compose (10 * 2 + 5):", composed(10))
