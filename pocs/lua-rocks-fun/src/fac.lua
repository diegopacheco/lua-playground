-- fac.lua
local function fac(n)
    if (n == 0) then
      return 1
    else
      return n * fac(n - 1)
    end
end
  
return fac