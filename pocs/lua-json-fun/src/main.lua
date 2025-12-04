local function encode_value(val)
    local t = type(val)
    if t == "string" then return '"' .. val .. '"'
    elseif t == "number" or t == "boolean" then return tostring(val)
    elseif t == "nil" then return "null"
    elseif t == "table" then
        local is_array, count = true, 0
        for k, v in pairs(val) do
            count = count + 1
            if type(k) ~= "number" or k ~= count then is_array = false; break end
        end
        if is_array and count > 0 then
            local parts = {}
            for i = 1, count do table.insert(parts, encode_value(val[i])) end
            return "[" .. table.concat(parts, ", ") .. "]"
        else
            local parts = {}
            for k, v in pairs(val) do
                table.insert(parts, '"' .. tostring(k) .. '": ' .. encode_value(v))
            end
            return "{" .. table.concat(parts, ", ") .. "}"
        end
    end
    return "null"
end

local function decode_value(str, pos)
    pos = pos or 1
    while pos <= #str and str:sub(pos, pos):match("%s") do pos = pos + 1 end
    local c = str:sub(pos, pos)
    if c == '"' then
        local endpos = str:find('"', pos + 1)
        return str:sub(pos + 1, endpos - 1), endpos + 1
    elseif c:match("%d") or c == "-" then
        local endpos = pos
        while endpos <= #str and str:sub(endpos, endpos):match("[%d%.eE%+%-]") do endpos = endpos + 1 end
        return tonumber(str:sub(pos, endpos - 1)), endpos
    elseif c == "t" then return true, pos + 4
    elseif c == "f" then return false, pos + 5
    elseif c == "n" then return nil, pos + 4
    end
end

print("Encode:")
print("Array:", encode_value({1, 2, 3, 4, 5}))
print("Object:", encode_value({name = "John", age = 30}))

print("\nDecode:")
local val, pos = decode_value('"hello"', 1)
print("String:", val)
